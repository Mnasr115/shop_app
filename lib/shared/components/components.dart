
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.type,
    required this.label,
    this.onTap,
    this.onChange,
    this.onFieldSubmitted,
    this.validate,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isPassword = false,
  });

  final TextEditingController textEditingController;
  final TextInputType type;
  final String label;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final void Function(String)? onFieldSubmitted;
  final dynamic validate;
  final dynamic prefix;
  final dynamic suffix;
  final dynamic suffixPressed;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        border: const OutlineInputBorder(),
        suffixIcon: GestureDetector(
          onTap: suffixPressed,
          child: Icon(suffix),
        ),
        prefixIcon: Icon(prefix),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING, }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
