import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../widgets/auth_footer_links.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(
    text: AppConstants.defaultUserName,
  );
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthSignupRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          AppSnackbar.showSuccess(
            context,
            'Account created! Welcome, ${state.user.displayName}.',
          );
        } else if (state is AuthFailure) {
          AppSnackbar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return AppScaffold(
          showBlueprintBanner: true,
          body: Center(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AuthHeader(
                      title: 'Create account',
                      subtitle: 'Start organizing your finances with Gallery Finance AI.',
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    AuthTextField(
                      controller: _nameController,
                      label: 'Full name',
                      hint: 'Muneeb Ur Rehman',
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        size: 20,
                      ),
                      validator: (v) =>
                          Validators.validateRequired(v, 'Full name'),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    AuthTextField(
                      controller: _emailController,
                      label: 'Email address',
                      hint: 'name@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email_outlined, size: 20),
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    AuthTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'At least 6 characters',
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: Validators.validatePassword,
                      onFieldSubmitted: (_) => _submitSignup(),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    AppButton(
                      label: 'Create account',
                      isLoading: isLoading,
                      onPressed: _submitSignup,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    AuthFooterLinks(
                      promptText: 'Already have an account?',
                      actionText: 'Sign in',
                      onTap: () => context.go(RouteNames.login),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
