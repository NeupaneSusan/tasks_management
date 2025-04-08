import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/app_color.dart';

InputDecoration inputDecoration({required String hintText, Widget? suffixIcon, EdgeInsetsGeometry? contentPadding}) => InputDecoration(
  contentPadding: contentPadding ?? EdgeInsets.all(8.0),
  hintText: hintText,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
  filled: true,
  fillColor: AppColor.lightColor,
  suffixIcon: suffixIcon,
);
