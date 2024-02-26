import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';

class FriendInputField extends StatelessWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String? val)? validator;
  final String? suffixText;
  final String? prefixText;
  final String? Function(String? val)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final bool hideText;
  final TextInputAction? textInputAction;
  final void Function(String? val)? onChanges;
  const FriendInputField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.controller,
      this.maxLines = 1,
      this.validator,
      this.suffixText,
      this.onFieldSubmitted,
      this.focusNode,
      this.prefixText,
      this.textInputType,
      this.hideText = false, this.textInputAction=TextInputAction.next, this.onChanges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(60), boxShadow: [
        BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            offset: const Offset(2, 6),
            blurRadius: 4,
            spreadRadius: 2)
      ]),
      child: TextFormField(
        onChanged: onChanges,
        textInputAction: textInputAction,
        obscureText: hideText,
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        validator: validator,
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        cursorColor: ColorManager.darkGreen,
        style: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          errorMaxLines: 3,
          suffixText: suffixText,
          prefixText: prefixText,
          suffixStyle:
              Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
          hintStyle: Theme.of(context).textTheme.labelSmall,
          prefixIcon: icon,
          hintText: hint,
        ),
      ),
    );
  }
}
