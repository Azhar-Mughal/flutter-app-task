import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormFieldWidget extends StatelessWidget {
  final TextEditingController mTextEditingController;
  final FocusNode mCurrentFocusNode, mNextFocusNode;
  final TextInputType mTextInputType;
  final TextInputAction mTextInputAction;
  final List<TextInputFormatter> mListOfInputFormatters;
  final Function(String)? mOnSubmit;
  final String mHintText;
  final Widget mSuffixWidget;
  final dynamic mValidator;

  const CommonTextFormFieldWidget({
    Key? key,
    required this.mTextEditingController,
    required this.mCurrentFocusNode,
    required this.mNextFocusNode,
    required this.mTextInputType,
    required this.mListOfInputFormatters,
    required this.mTextInputAction,
    required this.mOnSubmit,
    required this.mHintText,
    required this.mSuffixWidget,
    required this.mValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 60,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        TextFormField(
          controller: mTextEditingController,
          focusNode: mCurrentFocusNode,
          keyboardType: mTextInputType,
          inputFormatters: mListOfInputFormatters,
          onFieldSubmitted: mOnSubmit,
          textInputAction: mTextInputAction,
          validator: mValidator,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: mHintText,
            hintStyle: const TextStyle(fontSize: 15),
            fillColor: Colors.red,
            suffixIcon: mSuffixWidget,
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          ),
        ),
      ],
    );
  }
}
