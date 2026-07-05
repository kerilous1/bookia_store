import 'package:bookia_store/features/Authentication/presentation/pages/verification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../cubit/auth_state_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
                size: 18,
              ),
            ),
          ),
        ),
      ),
      body: AnimatedBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Header ──
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFFF5F3FF),
                              Color(0xFFA78BFA),
                            ],
                          ).createShader(bounds),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Start your reading adventure today',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40),

                        //name field
                        CustomTextField(
                          labelText: 'Full Name',
                          prefixIcon: Icons.person_outline,
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        //email field
                        CustomTextField(
                          labelText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          controller: _emailController,
                          validator: AppValidators.validateEmail,
                        ),
                        const SizedBox(height: 20),

                        //password field
                        CustomTextField(
                          labelText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                          validator: AppValidators.validatePassword,
                        ),
                        const SizedBox(height: 20),

                        //Confirm Password field
                        CustomTextField(
                          labelText: 'Confirm Password',
                          prefixIcon: Icons.lock_reset_outlined,
                          controller: _confirmPasswordController,
                          isPassword: true,
                          validator: (value) =>
                              AppValidators.validateConfirmPassword(
                            value,
                            _passwordController.text,
                          ),
                        ),
                        const SizedBox(height: 36),

                        //register button
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (ModalRoute.of(context)?.isCurrent == true) {
                              if (state is AuthStateSuccess) {
                                // 1. إظهار رسالة النجاح
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Registration successful',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: AppColors.success,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );

                                // 2. الانتقال لشاشة التحقق وناخد معانا الإيميل والـ Cubit
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<AuthCubit>(),
                                      child: VerificationPage(
                                        email: _emailController
                                            .text, // باصينا الإيميل هنا
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is AuthStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.message,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: AppColors.error,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              text: 'Register',
                              isLoading: state is AuthStateLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().register(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        confirmPassword:
                                            _confirmPasswordController.text,
                                      );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [
                                    Color(0xFF7C3AED),
                                    Color(0xFFDB2777),
                                  ],
                                ).createShader(bounds),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
