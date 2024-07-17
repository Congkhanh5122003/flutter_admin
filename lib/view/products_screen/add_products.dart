import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/products_controller.dart';
import 'package:flutteradmin/view/products_screen/components/product_dropdown.dart';
import 'package:flutteradmin/view/products_screen/components/product_images.dart';
import 'package:flutteradmin/view/widgets/custom_textfield.dart';
import 'package:flutteradmin/view/widgets/loading_indicator.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {

    var controller =Get.find<ProductsController>();
    
    return Obx(()=>
       Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
           leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: boldText(text: "Thêm sản phẩm",color: fontGrey,size: 16.0),
          actions: [
           controller.isloading.value?loadingIndicator(circleColor: white): TextButton(onPressed: ()async{
            controller.isloading(true);
              await controller.uploadImages();
              await controller.uploadProduct(context);
              Get.back();
            }, child: boldText(text: save,color: white))
          ],
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                  hint: "Tên sản phẩm",
                  label: "Tên sản phẩm",
                  controller: controller.pnameController
                ),
                10.heightBox,
                 customTextField(
                  hint: "Đẹp nhe",
                  label: "Mô tả",isDesc: true,
                  controller: controller.pdescController
                ),
                10.heightBox,
                 customTextField(
                  hint: "200.000",
                  label: "Giá",
                  controller: controller.ppriceController
                ),
                10.heightBox,
                 customTextField(
                  hint: "20",
                  label: "Số lượng",
                  controller: controller.pquantityController
                ),
                10.heightBox,
                productDropdown("Danh Mục",controller.categoryList,controller.categoryvalue,controller),
                20.heightBox,
                productDropdown("Danh mục nhỏ",controller.subcategoryList,controller.subcategoryvalue,controller),
                20.heightBox,
                const Divider(color: white,),
                normalText(text: "Chọn hình ảnh"),
                10.heightBox,
                Obx(()=>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(3,(index)=>controller.pImagesList[index] !=null ? Image.file(controller.pImagesList[index],width: 100,).onTap((){
                      controller.pickImage(index, context);
                    }): productImages (label: "${index +1}").onTap((){
                      controller.pickImage(index, context);
                    }
                    
                    )
                    ),
                  ),
                ),
                5.heightBox,
                normalText(text: "Hình ảnh đầu sẽ là chính",color: lightGrey),
                const Divider(color: white,),
                10.heightBox,
                boldText(text: "Chọn màu sản phẩm"),
                10.heightBox,
                Obx(()=>
                   Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(9,(index)=>Stack(
                      alignment: Alignment.center,
                      
                      children:[ VxBox().color(Vx.randomPrimaryColor).roundedFull.size(50, 50).make().onTap((){
                        controller.selectedColorIndex.value = index;
                      }),
                      controller.selectedColorIndex.value == index?
                      const Icon(Icons.done,color: white,):const SizedBox()
                      ])),
                  ),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}