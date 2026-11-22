import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: false),
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
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Campusly',
                    style: AppTextStyles.screenTitle(
                      context,
                    )?.copyWith(color: colors.primary),
                  ),
                  Text(
                    'Your campus, connected.',
                    style: AppTextStyles.caption(context),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text('Club Login', style: AppTextStyles.screenTitle(context)),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Manage your campus events',
                    style: AppTextStyles.body(context),
                  ),
                  const SizedBox(height: AppSpacing.xl),
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
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(label: 'Log In', onPressed: _logIn),
                  const SizedBox(height: AppSpacing.sm),
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
                  const SizedBox(height: AppSpacing.xl),
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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: colors.onSecondaryContainer),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.boxTitle(context)),
                const SizedBox(height: AppSpacing.xs),
                Text(message, style: AppTextStyles.caption(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
