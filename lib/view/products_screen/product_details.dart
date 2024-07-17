import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: darkGrey),
        ),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data['p_imgs'].length,
              // itemCount: data['p_imgs'].length,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  // data["p_imgs"][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  // title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,

                  Row(
                    children: [
                      boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0)
                    ],
                  ),





                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                ],
              ),
            ),
            10.heightBox,
            boldText(text: "${data['p_price']}", color: red, size: 18.0),
            // "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
            20.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: boldText(text: "Color",color: fontGrey),
                    //  child: "Color: ".text.color(textfieldGrey).make(),
                    ),
                    Row(
                      children: List.generate(
                         data['p_colors'].length,
                        
                        (index) => 
                        // Stack(
                        //   alignment: Alignment.center,
                        //   children: [
                            Column(
                              children: [
                                VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    
                                     .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                                    .make()
                                    .onTap(() {
                                  // controller.changeColorIndex(index);
                                }),
                                // Visibility(
                                //   visible: index == controller.colorIndex.value,
                                //   child: const Icon(Icons.done,color: Colors.white,))
                              ],
                            ),
                       //   ],
                        //),
                      ),
                    ),
                  ],
               // ).box.padding(const EdgeInsets.all(8)).make(),
                 ) ,
                 10.heightBox,
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: boldText(text: "Số lượng",color: fontGrey),
                    //  child: "Quantity: ".text.color(textfieldGrey).make(),
                    ),
                    normalText(text: "${data['p_quantity']} Sản phẩm",color: fontGrey),
                    // Row(
                    //   children: [
                    //     IconButton(onPressed: () {
                    //       controller.decreaseQuantity();
                    //       controller.calculateTotalPrice(int.parse(data['p_price']));
                    //     }, icon: const Icon(Icons.remove)),
                    //     controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                    //     IconButton(onPressed: () {
                    //       controller.IncreaseQuantity(int.parse(data['p_quantity']));
                    //       controller.calculateTotalPrice(int.parse(data['p_price']));
                    //     }, icon: const Icon(Icons.add)),
                    //     10.widthBox,
                    //     "(${data['p_quantity']}  available)".text.color(textfieldGrey).make(),
                    //   ],
                    // ),
                  ],
                ),//.box.padding(const EdgeInsets.all(8)).make(),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 100,
                //       child: "Total: ".text.color(textfieldGrey).make(),
                //     ),
                //     "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
              ],
            ).box.padding(const EdgeInsets.all(8)).make(),
             10.heightBox,
             const Divider(),
             boldText(text: "Mô tả",color: fontGrey),
                     // "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      normalText(text: "${data['p_desc']}",color: fontGrey)
                      //"${data['p_desc']}".text.color(darkFontGrey).make(),
          ],
        ).box.white.padding(const EdgeInsets.all(8)).make(),
        

      ),
    );
  }
}
