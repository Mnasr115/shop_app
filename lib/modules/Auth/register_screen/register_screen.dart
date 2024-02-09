import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var userNameController = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                      return 'Enter your name';
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
                  textEditingController: passwordController,
                  type: TextInputType.visiblePassword,
                  label: 'Password',
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Password is too short';
                    }
                  },
                  suffix: Icons.visibility_off_outlined,
                  prefix: Icons.lock,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'REGISTER',
                  onPressed: () {},
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
    );
  }
}
