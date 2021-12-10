import 'package:flutter/material.dart';
import 'package:get/get.dart';

InputDecoration inputDecorationStyleOne(
        {String? label = '', String? hint = '', Widget? icon}) =>
    InputDecoration(
        prefixIcon: icon,
        fillColor: Colors.grey.withOpacity(0.2),
        filled: true,
        label: Text(label!),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(2)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(2)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(2)),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(2)));
