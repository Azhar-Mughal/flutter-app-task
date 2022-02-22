import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final String mButtonText;
  final Function()? mOnPressed;

  const CommonButtonWidget({
    Key? key,
    required this.mButtonText,
    required this.mOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: mOnPressed,
      child: Text(
        mButtonText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
