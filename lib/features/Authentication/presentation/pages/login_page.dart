import 'package:bookia_store/core/widgets/custom_text_field.dart';
import 'package:bookia_store/features/Authentication/presentation/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/auth_state_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  
  //to clear the text fields
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              
              child:Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.menu_book_rounded,size: 80,color: AppColors.primaryBlue,),
                    const SizedBox(height: 24,),


                    const Text(
                      'welcome back to bookia',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40,),

                    CustomTextField(
                        labelText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        controller: _emailController,
                        validator: AppValidators.validateEmail,
                    ),
                    const SizedBox(height: 30,),

                    CustomTextField(
                      labelText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      controller: _passwordController,
                      validator: AppValidators.validatePassword,
                    ),
                    const SizedBox(height: 25,),

                    BlocConsumer<AuthCubit,AuthState>(
                      listener: (context,state){
                        if(state is AuthStateSuccess){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login successful'),
                            ),
                          );
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const HomePage()),
                          //   (route) => false,
                          // );
                          //TODO: navigate to home page
                        }
                        else if(state is AuthStateError){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context,state){
                        return CustomButton(
                          text: 'Login',
                          isLoading: state is AuthStateLoading,
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              context.read<AuthCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ?', style: TextStyle(color: AppColors.textGrey)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    // هنا بناخد نفس الـ Cubit بتاع شاشة اللوجين ونديه للريجيستر
                                    value: context.read<AuthCubit>(),
                                    child: const RegisterPage(),
                                  ),
                                ),
                                );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ) ,
            ),
          )
      ),
    );
  }
}
