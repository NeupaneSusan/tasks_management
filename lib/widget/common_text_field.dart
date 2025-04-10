import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/input_decoration.dart';
import 'package:taskmgt/core/constant/text_style.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hintText;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const CommonTextField({
    super.key,
    required this.textEditingController,
    required this.title,
    required this.hintText,
    this.suffixIcon,
    this.readOnly = false,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(title, style: AppTextStyle.font15W5),
        TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          validator: validator,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 19),
          controller: textEditingController,
          cursorHeight: 20,
          decoration: inputDecoration(hintText: hintText, suffixIcon: suffixIcon),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
