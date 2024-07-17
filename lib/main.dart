import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutteradmin/const/const.dart';
import 'package:flutteradmin/view/auth_screen/login_screen.dart';
import 'package:flutteradmin/view/home_screen/home.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }






  var isLoggedin=false;
  checkUser()async{
   auth.authStateChanges().listen((User? user) {
  if (user == null && mounted) {
    isLoggedin = false;
  } else {
    isLoggedin = true;
  }
  setState(() {});
});


  }
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp  (
      debugShowCheckedModeBanner: false,
      title:appname,
      home: isLoggedin ? const Home(): const LoginScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0
        ),
        
      ),
     
    );
  }
}
