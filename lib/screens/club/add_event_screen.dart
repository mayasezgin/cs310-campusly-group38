import 'package:flutter/material.dart';

import '../../data/sample_club_events.dart';
import '../../models/event.dart';
import '../../utils/date_labels.dart';
import '../../utils/event_category_labels.dart';
import '../../utils/validators.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/form/labeled_text_field.dart';
import '../../widgets/primary_button.dart';

/// Form that lets a club create a new event.
///
/// After a valid submission an "Event Created" dialog is shown and the new
/// [Event] is returned to the Club Dashboard with `Navigator.pop`.
class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key, this.now});

  static const routeName = '/club/add-event';

  /// Overrides the current time (used by tests).
  final DateTime Function()? now;

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  EventCategory? _category;

  DateTime get _now => widget.now?.call() ?? DateTime.now();

  DateTime get _today => DateTime(_now.year, _now.month, _now.day);

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _startController.dispose();
    _endController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? _today,
      // Past dates cannot be selected.
      firstDate: _today,
      lastDate: _today.add(const Duration(days: 365)),
    );
    if (picked == null) return;
    setState(() {
      _date = picked;
      _dateController.text = longDateLabel(picked);
    });
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          (isStart ? _startTime : _endTime) ??
          (isStart
              ? const TimeOfDay(hour: 16, minute: 0)
              : const TimeOfDay(hour: 18, minute: 0)),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startTime = picked;
        _startController.text = timeLabel(picked);
      } else {
        _endTime = picked;
        _endController.text = timeLabel(picked);
      }
    });
  }

  String? _validateDate(String? _) {
    if (_date == null) return 'Date is required.';
    if (_date!.isBefore(_today)) return 'Date cannot be in the past.';
    return null;
  }

  String? _validateStart(String? _) {
    if (_startTime == null) return 'Start time is required.';
    if (_date != null && !_combine(_date!, _startTime!).isAfter(_now)) {
      return 'Start time must be in the future.';
    }
    return null;
  }

  String? _validateEnd(String? _) {
    if (_endTime == null) return 'End time is required.';
    if (_startTime != null) {
      final start = _startTime!.hour * 60 + _startTime!.minute;
      final end = _endTime!.hour * 60 + _endTime!.minute;
      if (end <= start) return 'End time must be after start time.';
    }
    return null;
  }

  Future<void> _publish() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Please fix the highlighted fields.')),
        );
      return;
    }

    final startAt = _combine(_date!, _startTime!);
    final event = Event(
      id: 'club-${startAt.millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      startAt: startAt,
      endAt: _combine(_date!, _endTime!),
      location: _locationController.text.trim(),
      category: _category!,
      organizerName: sampleClubName,
    );

    await showConfirmationDialog(
      context,
      title: 'Event Created',
      message:
          '"${event.title}" has been published and is now visible '
          'to students.',
      buttonLabel: 'Back to Dashboard',
    );
    if (mounted) Navigator.of(context).pop(event);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Create New Event')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'All fields are required.',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        LabeledTextField(
                          label: 'Event Title',
                          controller: _titleController,
                          hintText: 'Enter an event title',
                          textInputAction: TextInputAction.next,
                          validator: (value) => Validators.length(
                            value,
                            'Event title',
                            min: 3,
                            max: 80,
                          ),
                        ),
                        LabeledTextField(
                          label: 'Date',
                          controller: _dateController,
                          hintText: 'Select a date',
                          readOnly: true,
                          onTap: _pickDate,
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                          validator: _validateDate,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: LabeledTextField(
                                label: 'Start Time',
                                controller: _startController,
                                hintText: 'Start',
                                readOnly: true,
                                onTap: () => _pickTime(isStart: true),
                                suffixIcon: const Icon(Icons.schedule),
                                validator: _validateStart,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: LabeledTextField(
                                label: 'End Time',
                                controller: _endController,
                                hintText: 'End',
                                readOnly: true,
                                onTap: () => _pickTime(isStart: false),
                                suffixIcon: const Icon(Icons.schedule),
                                validator: _validateEnd,
                              ),
                            ),
                          ],
                        ),
                        LabeledTextField(
                          label: 'Location',
                          controller: _locationController,
                          hintText: 'e.g. Innovation Lab · Room 204',
                          textInputAction: TextInputAction.next,
                          suffixIcon: const Icon(Icons.location_on_outlined),
                          validator: (value) =>
                              Validators.length(value, 'Location', min: 3),
                        ),
                        FieldLabel(
                          label: 'Category',
                          child: DropdownButtonFormField<EventCategory>(
                            initialValue: _category,
                            isExpanded: true,
                            hint: const Text('Select a category'),
                            decoration: campuslyInputDecoration(context),
                            items: [
                              for (final category in EventCategory.values)
                                DropdownMenuItem(
                                  value: category,
                                  child: Text(categoryLabel(category)),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _category = value),
                            validator: (value) =>
                                value == null ? 'Category is required.' : null,
                          ),
                        ),
                        LabeledTextField(
                          label: 'Description',
                          controller: _descriptionController,
                          hintText:
                              'Describe your event, what students will do, '
                              'and what to bring.',
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          validator: (value) => Validators.length(
                            value,
                            'Description',
                            min: 10,
                            max: 500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: PrimaryButton(label: 'Publish Event', onPressed: _publish),
            ),
          ],
        ),
      ),
    );
  }
}
