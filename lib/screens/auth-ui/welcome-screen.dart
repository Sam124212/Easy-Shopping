import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConstant.appMainColor,
        title: Center(child: Text("Welcome",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(color:AppConstant.appMainColor,child: Lottie.asset("assets/lottie/1.json"),),
            SizedBox(height: 12,),
            Container(child: Text("Happy Shopping",style: TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(height: 12,),
            Container(
              width: 250,
              height: 65,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextButton.icon(icon:Icon(Icons.g_mobiledata,size: 50,color: Colors.white,),onPressed: (){}, label: Text("Sign up with Google",style: TextStyle(color: Colors.white),))),
            SizedBox(height: 5,),
            Container(
              width: 250,
              height: 65,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextButton.icon(icon:Icon(Icons.email_outlined,size: 35,color: Colors.white,),onPressed: (){}, label: Text("Sign up with Email",style: TextStyle(color: Colors.white),)))
          ],
        ),
      ),
    );
  }
}
