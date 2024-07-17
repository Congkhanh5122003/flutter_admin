import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/const/strings.dart';
import 'package:flutteradmin/controllers/profile_controller.dart';
import 'package:flutteradmin/view/widgets/custom_textfield.dart';
import 'package:flutteradmin/view/widgets/loading_indicator.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';

class EditProfilescreen extends StatefulWidget {
  final String ? username;
  const EditProfilescreen({super.key,this.username});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text  = widget.username!;
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    
    return Obx(()=>
       Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile,size: 16.0),
          actions: [
            controller.isloading.value ?loadingIndicator():
            
             TextButton(onPressed: ()async{
      
              controller.isloading(true);
      
                      if(controller.profileImgPath.value.isNotEmpty){
                        await controller.uploadProfileImage();
      
                      }else{
                        controller.profileImageLink=controller.snapshotData ['imageUrl'];
                      }
      
      
      
      
                      if(controller.snapshotData['password']==controller.oldpassController.text){
      
      
                      await  controller.changeAuthPassword(
                        email: controller.snapshotData['email'],
                        password: controller.oldpassController.text,
                        newpassword: controller.newpassController.text
                      );
      
      
      
                        await controller.updateProfile(
                        imgUrl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.newpassController.text,
                      );
                      VxToast.show(context, msg: "Updated");
                      }else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull){
      
      
                         await controller.updateProfile(
                        imgUrl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.snapshotData['password']);
      
      
      
                       
                      }else{
                         VxToast.show(context, msg: "Sai mat khau cu");
                        controller.isloading(false);
                      }
      
             }, child: normalText(text: save)),
      
          ],
        ),
        body: Padding(padding: const EdgeInsets.all(8.0),
        child: 
           Column(
            children: [
          
              controller.snapshotData['imageUrl']==''&&
                  controller.profileImgPath.isEmpty
                      ? Image.asset(
                          imgProduct,
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : 
                      controller.snapshotData['imageUrl']!=''&& controller.profileImgPath.isEmpty?
                      
          
                      Image.network(controller.snapshotData['imageUrl'],width: 100,
                          fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
                      Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
          
          
          
            //  Image.asset(imgProduct,width: 150).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: white
                ),
                onPressed: (){
                  controller.changeImage(context);
                }, child: normalText(text: changeImage,color: fontGrey),
                ),
                10.heightBox,
                const Divider(color: white),
                
                10.heightBox,
                customTextField(label:name,hint: "name",controller: controller.nameController),
                30.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Đổi mật khẩu")),
                10.heightBox,
                customTextField(label: password,hint: passwordHint,controller: controller.oldpassController),
                10.heightBox,
                customTextField(label: confirmPass,hint: passwordHint,controller: controller.newpassController),
                
          
          
            ],
          ),
        
        ),
      ),
    );
  }
}