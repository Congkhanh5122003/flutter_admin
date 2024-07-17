import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/controllers/home_controller.dart';
import 'package:flutteradmin/view/home_screen/home_screen.dart';
import 'package:flutteradmin/view/orders_screen.dart/orders_screen.dart';
import 'package:flutteradmin/view/products_screen/products_screen.dart';
import 'package:flutteradmin/view/profile_screen/profile_screen.dart';
import 'package:flutteradmin/view/widgets/text_style.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens=[
      const HomeScreen(),const ProductsScreen(),const OrdersScreen(),const ProfileScreen()
    ];



   var bottomNavbar = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home), label: dashboard   
    ),
      BottomNavigationBarItem(
      icon: Image.asset(icProducts,color: darkGrey,width: 24,),label: products    
    ),
      BottomNavigationBarItem(
      icon: Image.asset(icOrders,width: 24,color: darkGrey,),label:  orders
    ),
      BottomNavigationBarItem(
      icon: Image.asset(icGeneralSetting,width: 24,color: darkGrey,), label: settings   
    ),
   ]    ;

    return Scaffold(
      bottomNavigationBar: Obx(
        ()=>
        BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value=index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        
          items: bottomNavbar,),
      ),
      body: Obx(()=>
         Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}