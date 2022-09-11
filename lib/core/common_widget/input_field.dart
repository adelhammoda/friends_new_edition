import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';

class FriendInputField extends StatelessWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String? val)? validator;
  const FriendInputField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.controller,
       this.maxLines = 1,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            offset: const Offset(2,6),
            blurRadius:4,
            spreadRadius:2
          )
        ]
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        minLines: 1,
        maxLines: maxLines,
        cursorColor: ColorManager.darkGreen,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.labelSmall,
          prefixIcon: icon,
          hintText: hint,
        ),
      ),
    );
  }
}
