import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/form/labeled_text_field.dart';
import '../../widgets/form/password_field.dart';
import '../../widgets/primary_button.dart';

/// Sign-up screen where a student club requests an account.
///
/// UI-only in Step 2.2: a valid form shows a confirmation dialog explaining
/// that the account needs approval, then returns to Club Login.
class ClubSignUpScreen extends StatefulWidget {
  const ClubSignUpScreen({super.key});

  static const routeName = '/club/signup';

  @override
  State<ClubSignUpScreen> createState() => _ClubSignUpScreenState();
}

class _ClubSignUpScreenState extends State<ClubSignUpScreen> {
  static const _minPasswordLength = 8;

  final _formKey = GlobalKey<FormState>();
  final _clubNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _clubNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    await showConfirmationDialog(
      context,
      title: 'Request Sent',
      message:
          '${_clubNameController.text.trim()} has been registered. '
          'You can log in once your club account is approved.',
      buttonLabel: 'Back to Login',
      icon: Icons.mark_email_read_outlined,
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Club Login'), centerTitle: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Club Sign Up', style: AppTextStyles.screenTitle(context)),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Register your club to publish campus events',
                  style: AppTextStyles.body(context),
                ),
                const SizedBox(height: AppSpacing.xl),
                LabeledTextField(
                  label: 'Club Name',
                  controller: _clubNameController,
                  hintText: 'e.g. Campus Sustainability Club',
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      Validators.length(value, 'Club name', min: 3, max: 60),
                ),
                LabeledTextField(
                  label: 'Email',
                  controller: _emailController,
                  hintText: 'club@university.edu',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email,
                ),
                PasswordField(
                  label: 'Password',
                  controller: _passwordController,
                  hintText: 'At least $_minPasswordLength characters',
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      Validators.password(value, minLength: _minPasswordLength),
                ),
                PasswordField(
                  label: 'Confirm Password',
                  controller: _confirmController,
                  hintText: 'Re-enter your password',
                  textInputAction: TextInputAction.done,
                  validator: (value) => Validators.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: colors.onSecondaryContainer,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Club accounts require approval before they can '
                          'publish events.',
                          style: AppTextStyles.caption(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(label: 'Sign Up', onPressed: _signUp),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Log In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
