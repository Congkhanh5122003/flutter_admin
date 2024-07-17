import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/auth_controller.dart';
import 'package:flutteradmin/controllers/profile_controller.dart';
import 'package:flutteradmin/services/store_services.dart';
import 'package:flutteradmin/view/auth_screen/login_screen.dart';
import 'package:flutteradmin/view/messages_sceen/messages_screen.dart';
import 'package:flutteradmin/view/profile_screen/edit_profilescreen.dart';
import 'package:flutteradmin/view/shop_screen/shop_setting_screen.dart';
import 'package:flutteradmin/view/widgets/loading_indicator.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings,size: 16.0),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> EditProfilescreen(
              username: controller.snapshotData['vendor_name'],
            ));
          }, icon: const Icon(Icons.edit)),
           IconButton(onPressed: ()async{

            await Get.find<AuthController>().signoutMethod(context);
            Get.offAll(()=>const LoginScreen());

           }, icon: normalText(text: logout)),

        ],
      ),

      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid), 
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
          if (!snapshot.hasData){
            return loadingIndicator(circleColor: white);
          }else{

            controller.snapshotData =snapshot.data!.docs[0];



            return Column(
        children: [
          ListTile(
            leading:  controller.snapshotData['imageUrl']==''?
                  Image.asset(imgProduct,width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
                  Image.network(controller.snapshotData['imageUrl'],width: 100,).box.roundedFull.clip(Clip.antiAlias).make(),
            //leading: Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
            title: boldText(text: "${controller.snapshotData['vendor_name']}"),
            subtitle: normalText(text: "${controller.snapshotData['email']}"),

          ),
          const Divider(),
          10.heightBox,
          Padding(padding: const EdgeInsets.all(8.0),
          child: Column(
            children: List.generate(profileButtonsIcons.length, (index)=>ListTile(
              onTap: (){
                switch (index){
                  case 0:
                  Get.to(()=>const ShopSettingScreen());

                  break;

                   case 1:
                  Get.to(()=>const MessagesScreen());

                  break;


                  default:
                }
              },
              leading: Icon(profileButtonsIcons[index],color: white),
              title: normalText(text: profileButtonsTitles[index]),
            )),
          )
          
          
          )
        ],
      );
          }
          
        }),



    
    );
  }
}