import 'dart:async';

import 'package:ecommreceapp/controller/get-userdata-controller.dart';
import 'package:ecommreceapp/screens/admin-panel/admin-main-screen.dart';
import 'package:ecommreceapp/screens/auth-ui/login-screen.dart';
import 'package:ecommreceapp/screens/user-panel/main-screen.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../auth-ui/welcome-screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Delayed navigation to WelcomeScreen
    Timer(
      Duration(seconds: 3),
      () {
loggedIn(context);
},);
  }

  Future<void> loggedIn(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if(userData [0]["isAdmin"] == true){
        Get.offAll(()=> AdminMianScreen());
      }else{
        Get.offAll(()=> MainScreen());
      }

    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appScendoryColor,
      body: Center(
        child: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/1.json", width: 300),
              SizedBox(height: 20),
              Text(AppConstant.appPoweredBy),
            ],
          ),
        ),
      ),
    );
  }
}
