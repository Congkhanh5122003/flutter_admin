import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/home_controller.dart';
import 'package:flutteradmin/models/category_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductsController extends GetxController {

  var isloading =false.obs;



  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLink = [];
  var pImagesList = RxList<dynamic>.generate(3, (index)=>null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  // Load categories from JSON
  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
    populateCategoryList();
  }

  // Populate category list with category names
   populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  // Populate subcategory list based on selected category
   populateSubcategory(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i =0 ;i<data.first.subcategory.length;i++){
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index,context)async{
    try{
      final img =await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
      if(img == null){
        return;
      }else{
        pImagesList[index]=File(img.path);
      }

    }catch(e){
      VxToast.show(context, msg: e.toString());

    }


  }

  uploadImages()async{
    pImagesLink.clear();
    for(var item in pImagesList){
        if(item!=null){   
  var filename=basename(item.path);
  var destination ='image/vendors/${currentUser!.uid}/$filename';
  Reference ref=FirebaseStorage.instance.ref().child(destination);
  await ref.putFile(item);
  var n = await ref.getDownloadURL();
  pImagesLink.add(n);

        }

    }
  }



  uploadProduct(context)async{
    var store = firestore.collection(productsCollection).doc();
    await store.set({
       'is_featured':false,
       'p_category':categoryvalue.value,
       'p_subcategory':subcategoryvalue.value,
       'p_colors':FieldValue.arrayUnion([Colors.red.value,Colors.brown.value]),
       'p_imgs':FieldValue.arrayUnion(pImagesLink),
       'p_wishlist':FieldValue.arrayUnion([]),
       'p_desc':pdescController.text,
       'p_name':pnameController.text,
       'p_price':ppriceController.text,
       'p_quantity':pquantityController.text,
       'p_seller':Get.find<HomeController>().username,
       'p_rating':"5.0",
       'vendor_id':currentUser!.uid,
       'featured_id':''

    });
    isloading(false);
    VxToast.show(context, msg: "Đăng sản phẩm thành công");
  }


  addFeatured(docId)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id':currentUser!.uid,
      'is_featured':true


    },SetOptions(merge: true));
  }

   removeFeatured(docId)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id':'',
      'is_featured':false


    },SetOptions(merge: true));
  }

  removeProduct(docId)async{
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}