
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.btnFunc,
      required this.btnText,
      required this.btnColor})
      : super(key: key);

  final Function() btnFunc;
  final String btnText;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: btnFunc,
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
            primary: btnColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Text(btnText));
  }
}