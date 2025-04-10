import 'package:flutter/material.dart';

InputDecoration inputDecoration({required String hintText, Widget? suffixIcon, EdgeInsetsGeometry? contentPadding}) => InputDecoration(
  suffixIcon: suffixIcon,
  hintText: hintText,
  contentPadding: const EdgeInsets.all(8),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
);
