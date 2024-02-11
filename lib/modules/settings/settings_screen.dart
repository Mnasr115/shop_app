import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/login_model/LoginModel.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constant.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel!;
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        textEditingController: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
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
                        label: 'Email Address',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                        },
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        textEditingController: phoneController,
                        type: TextInputType.phone,
                        label: 'Enter your phone',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }
                        },
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        text: 'UPDATE',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUser(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'LOGOUT',
                        onPressed: () {
                          signOut(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
