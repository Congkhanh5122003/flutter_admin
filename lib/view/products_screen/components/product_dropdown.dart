import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/products_controller.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productDropdown( hint, List<String>list,  dropvalue, ProductsController controller) {
  return Obx(()=>
    DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Danh Mục") {
            controller.subcategoryvalue.value = '';
            controller.populateSubcategory(newValue.toString());
          }
          dropvalue.value = newValue.toString();
        },
      ),
    ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}
