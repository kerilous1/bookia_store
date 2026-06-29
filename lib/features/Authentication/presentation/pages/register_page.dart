import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_state_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey=GlobalKey<FormState>();
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController=TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: ()=>Navigator.pop(context),
        ),
      ),
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text(
                      'Sign up to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40,),
                
                    //name field
                    CustomTextField(
                      labelText: 'Name',
                      prefixIcon: Icons.person_outline,
                      controller: _nameController,
                      validator: (value){
                        if(value==null||value.trim().isEmpty){
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30,),
                
                    //email field
                    CustomTextField(
                      labelText: 'Email' ,
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      validator: AppValidators.validateEmail,
                    ),
                    const SizedBox(height: 16),
                
                    //password field
                    CustomTextField(
                      labelText: 'Password' ,
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                      isPassword: true,
                      validator: AppValidators.validatePassword,
                    ),
                    const SizedBox(height: 16),
                
                    //Confirm Password field
                    CustomTextField(
                      labelText: 'Confirm Password',
                      prefixIcon: Icons.lock_reset_outlined,
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (value) => AppValidators.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 32),
                
                    //register button
                    BlocConsumer<AuthCubit,AuthState>(
                      listener: (context,state){
                        if(state is AuthStateSuccess){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration successful'),
                            ),
                          );
                        }
                        if(state is AuthStateError){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      builder: (context,state){
                        return CustomButton(
                          text: 'Register',
                          isLoading: state is AuthStateLoading,
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              context.read<AuthCubit>().register(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                confirmPassword: _confirmPasswordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?', style: TextStyle(color: AppColors.textGrey)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
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
              ),
            ),
          )
      ),
    );
  }
}
