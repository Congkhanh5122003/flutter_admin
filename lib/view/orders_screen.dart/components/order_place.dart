

import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               boldText(text: "$title1",color: purpleColor),
               boldText(text: "$d1",color: red),

              // "$title1".text.fontFamily(semibold).make(),
              // "$d1".text.color(redColor).fontFamily(semibold).make(),
            ],
          ),
        ),
        const SizedBox(width: 16), // Khoảng cách giữa hai cột
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              boldText(text: "$title2",color: purpleColor),
               boldText(text: "$d2",color: fontGrey),





              // "$title2".text.fontFamily(semibold).make(),
              // "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
