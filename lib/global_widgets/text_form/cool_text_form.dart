import 'package:flutter/material.dart';

class CoolTextFormCustom extends StatelessWidget {
  const CoolTextFormCustom(
      {Key? key,
      this.height = 70,
      this.label = '',
      this.padding,
      this.controller,
      this.textInputAction,
      this.textAlign = TextAlign.start})
      : super(key: key);

  final double height;
  final String label;

  final TextEditingController? controller;

  final TextInputAction? textInputAction;

  final EdgeInsetsGeometry? padding;

  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        textAlign: textAlign,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            hintStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22)),
      )),
    );
  }
}
