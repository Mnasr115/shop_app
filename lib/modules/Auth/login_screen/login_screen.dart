import 'package:flutter/material.dart';
import 'package:shop_app/modules/Auth/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
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
                  image: AssetImage('assets/images/login.png'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text('LOGIN', style: Theme.of(context).textTheme.displaySmall),
                Text(
                  'Login now to browse our hot offers ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 15,
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
                  text: 'LOGIN',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account ?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'REGISTER',
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
