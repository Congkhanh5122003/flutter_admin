import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';

Widget customTextField({label,hint,controller,isDesc=false}){
  return TextFormField(

    controller: controller,
    style: const TextStyle(color: white),
    maxLines: isDesc?4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white
        )
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey)
    ),
  );
}