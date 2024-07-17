import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/orders_controller.dart';
import 'package:flutteradmin/services/store_services.dart';
import 'package:flutteradmin/view/orders_screen.dart/order_details.dart';
import 'package:flutteradmin/view/widgets/appbar_widget.dart';
import 'package:flutteradmin/view/widgets/loading_indicator.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(OrdersController());


    return Scaffold(
      appBar: appbarWidget(orders),
      body:StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return loadingIndicator();
          }else{

            var data = snapshot.data!.docs;


            return  
            Padding(padding: const EdgeInsets.all(8.0),child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: List.generate(
            data.length,
             (index){


              var time = data[index]['order_date'].toDate();
              


              return ListTile(
            
                    onTap: (){
                      Get.to(()=> OrderDetails(data: data[index]));
                    },
                    tileColor: textfieldGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    title: boldText(text: "${data[index]['order_code']}",color: purpleColor),
                    subtitle: Column(
                      children: [

                        Row(
                          children: [
                            const Icon(Icons.calendar_month,color: fontGrey,),
                            10.heightBox,
                            boldText(text: intl.DateFormat().add_yMd().format(time),color: fontGrey)
                          ],
                        ),

                         Row(
                          children: [
                            const Icon(Icons.payment,color: fontGrey,),
                            10.heightBox,
                            boldText(text: unpaid,color: red)
                          
                          ],
                        )

                         
                      //  normalText(text: "\$40",color: darkGrey),
                      ],
                    ),
                    trailing: boldText(text: "${data[index]['total_amount']}",color: purpleColor,size: 16.0),
                  ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }
                  ),
        ),
      ),
      );
          }
        },
        
      )
    );
  }
}