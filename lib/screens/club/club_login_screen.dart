import 'package:flutter/material.dart';

import '../../utils/validators.dart';
import '../../widgets/form/labeled_text_field.dart';
import '../../widgets/form/password_field.dart';
import '../../widgets/primary_button.dart';
import 'club_dashboard_screen.dart';
import 'club_signup_screen.dart';

/// Login screen for authorized student clubs.
///
/// Step 2.2 is UI-only: when the form is valid we navigate straight to the
/// Club Dashboard. Firebase Authentication will replace this in Step 3.
class ClubLoginScreen extends StatefulWidget {
  const ClubLoginScreen({super.key});

  static const routeName = '/club/login';

  @override
  State<ClubLoginScreen> createState() => _ClubLoginScreenState();
}

class _ClubLoginScreenState extends State<ClubLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Please fix the errors above.')),
        );
      return;
    }
    Navigator.of(context).pushReplacementNamed(ClubDashboardScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Campusly',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  Text('Your campus, connected.', style: textTheme.bodySmall),
                  const SizedBox(height: 32),
                  Text(
                    'Club Login',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your campus events',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  LabeledTextField(
                    label: 'Email',
                    controller: _emailController,
                    hintText: 'club@university.edu',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    validator: Validators.email,
                  ),
                  PasswordField(
                    label: 'Password',
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(label: 'Log In', onPressed: _logIn),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => Navigator.of(
                          context,
                        ).pushNamed(ClubSignUpScreen.routeName),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const _InfoBox(
                    title: 'For authorized student clubs',
                    message:
                        'Regular students can browse campus events '
                        'without logging in.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: colors.onSecondaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(message, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
