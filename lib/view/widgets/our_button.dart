import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';

Widget ourButton({title,color=purpleColor,onPress}){


  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: color,
      padding: const EdgeInsets.all(12)
    ),
    
    
    onPressed: onPress, child: normalText(text: title,size: 16.0));
}