import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/constants/mock_constants.dart';
import '../../../../core/services/supabase_service.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _fillDemoCredentials() {
    _emailController.text = MockConstants.mockDemoEmail;
    _passwordController.text = MockConstants.mockDemoPassword;
    _submitLogin();
  }

  @override
  Widget build(BuildContext context) {
    final isSupaConfigured = SupabaseService.instance.isConfigured;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          AppSnackbar.showSuccess(
            context,
            'Welcome back, ${state.user.displayName}!',
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
                      title: 'Welcome back',
                      subtitle:
                          'Sign in to access your financial intelligence.',
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    if (!isSupaConfigured) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreenLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryGreen),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              color: AppColors.primaryGreenDark,
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                'Running in blueprint preview mode. One-click demo login is available below.',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primaryGreenDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],

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
                      hint: '••••••••',
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
                      onFieldSubmitted: (_) => _submitLogin(),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    AppButton(
                      label: 'Sign in',
                      isLoading: isLoading,
                      onPressed: _submitLogin,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Quick Demo / Reviewer shortcut button
                    AppButton(
                      label: 'Quick Demo Sign In (Blueprint)',
                      variant: AppButtonVariant.secondary,
                      onPressed: isLoading ? null : _fillDemoCredentials,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    AuthFooterLinks(
                      promptText: "Don't have an account?",
                      actionText: 'Sign up',
                      onTap: () => context.go(RouteNames.signup),
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
