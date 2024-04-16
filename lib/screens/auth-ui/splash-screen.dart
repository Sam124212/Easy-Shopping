import 'dart:async';

import 'package:ecommreceapp/screens/auth-ui/welcome-screen.dart';
import 'package:ecommreceapp/screens/user-panel/main-screen.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:3 ),(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WelcomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appScendoryColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Lottie.asset("assets/lottie/1.json",width: 300)),
            Text(AppConstant.appPoweredBy)
          ],
        ),
      ),
    );
  }
}
