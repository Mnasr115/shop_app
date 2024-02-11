import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/Auth/register_screen/cubit/register_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/Cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var userNameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value){
                token = state.loginModel.data?.token;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                );
              });
            } else {
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Image(
                          image: AssetImage(
                            'assets/images/login.png',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register and show our hot offers ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          textEditingController: userNameController,
                          type: TextInputType.name,
                          label: 'Enter your name',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          textEditingController: emailController,
                          type: TextInputType.emailAddress,
                          label: 'E-mail Address',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            }
                          },
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          textEditingController: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your number';
                            }
                          },
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          textEditingController: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                name: userNameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => CustomButton(
                            text: 'REGISTER',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.blue),
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
          );
        },
      ),
    );
  }
}
