import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/orders_controller.dart';
import 'package:flutteradmin/view/orders_screen.dart/components/order_place.dart';
import 'package:flutteradmin/view/widgets/our_button.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {


  final dynamic data;



  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
   var controller =Get.find<OrdersController>();

   @override
  void initState() {
    
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value =widget.data['order_confirmed'];
     controller.ondelivery.value =widget.data['order_on_delivery'];
      controller.delivered.value =widget.data['order_delivery'];
       
  }


  @override
  Widget build(BuildContext context) {
   
    return Obx(()=>
       Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            }, 
            icon: const Icon(Icons.arrow_back, color: darkGrey),
          ),
          title: boldText(text: "Thông tin hóa đơn", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,onPress: (){
                controller.confirmed(true);
                controller.changeStatus(title: "order_confirmed",status: true,docID: widget.data.id);
              },title: "Xác nhận đơn"
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
      
      
      
                Visibility(
                  visible: !controller.confirmed.value,
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                  
                  
                  
                    children: [
                  
                      boldText(text: "Trạng thái đơn hàng",color: purpleColor,size: 16.0),
                  
                      SwitchListTile(
                        activeColor: green,
                        
                        value: true, onChanged: (value){},
                      title: boldText(text: "Chờ xác nhận",color: fontGrey),
                      ),
                       SwitchListTile(
                        activeColor: green,
                        
                        value: controller.confirmed.value, onChanged: (value){
                          
                          controller.confirmed.value = value;
                        },
                      title: boldText(text: "Xác nhận",color: fontGrey),
                      ),
                       SwitchListTile(
                        activeColor: green,
                        
                        value: controller.ondelivery.value, onChanged: (value){
                        
                controller.changeStatus(title: "order_on_delivery",status: value,docID: widget.data.id);
                          controller.ondelivery.value = value;
                        },
                      title: boldText(text: "Đang giao",color: fontGrey),
                      ),
                       SwitchListTile(
                        activeColor: green,
                        
                        value: controller.delivered.value, onChanged: (value){
                        
                controller.changeStatus(title: "order_delivery",status: value,docID: widget.data.id);
                          controller.delivered.value = value;
                        },
                      title: boldText(text: "Đã giao",color: fontGrey),
                      )
                    ],
                  
                  
                  
                  
                  ).box.padding(const EdgeInsets.all(8)).outerShadowMd.white.border(color: lightGrey).roundedSM.make(),
                ),
      
      
      
      
      
      
      
               
                Column(
                  children: [
                    orderPlaceDetails(
                  d1:"${widget.data['order_code']}",
                  d2:"${widget.data['shipping_method']}",
                  title1: "Mã đơn hàng",
                  title2: "Tình trạng giao hàng"
            
            
                ),
                orderPlaceDetails(
      
                  
                  d1:intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate())),
                  d2:"${widget.data['payment_method']}",
                  title1: "Ngày đặt",
                  title2: "Hình thức thanh toán"
            
            
                ),
                 orderPlaceDetails(
                  d1:"Chưa thanh toán",
                  d2:"Nơi đặt",
                  title1: "Tình trạng thanh toán",
                  title2: "Tình trạng giao hàng"
            
            
                ),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  16.0,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         // "Địa chỉ giao hàng".text.fontFamily(semibold).make(),
      
                         boldText(text: "Địa chỉ giao hàng",color: purpleColor),
                          "${widget.data['order_by_name']}".text.make(),
                          "${widget.data['order_by_email']}".text.make(),
                          "${widget.data['order_by_address']}".text.make(),
                          "${widget.data['order_by_city']}".text.make(),
                          "${widget.data['order_by_state']}".text.make(),
                          "${widget.data['order_by_phone']}".text.make()
                          
                  
                  
                  
                  
                  
                  
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
      
      
                            boldText(text: "Tổng cộng",color: purpleColor),
                            boldText(text: "${widget.data['total_amount']}",color: red),
      
      
      
                            // "Tổng cộng".text.fontFamily(semibold).make(),
                            // "${data['total_amount']}".text.color(redColor).fontFamily(bold).make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
                  ],
                ).box.outerShadowMd.border(color: lightGrey).roundedSM.white.make(),
            
                const Divider(),
                10.heightBox,
                 
                  boldText(text: "Sản phẩm",color: fontGrey,size: 16.0),
      
               // "Sản phẩm".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1:"${controller.orders[index]['title']}",
                          title2: "${controller.orders[index]['tprice']}",
                          d1: "${controller.orders[index]['qty']}x",
                          d2: " Trả hàng"
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            
                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['color']),
                       //     color: Color(data['orders'][index]['color']),
                          ),
                        ),
                        const Divider()
      
                      ],
                    );
                  }).toList(),
                ).box.shadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
                20.heightBox,
                
                
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
