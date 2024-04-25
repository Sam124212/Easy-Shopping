import 'package:ecommreceapp/controller/forgot-pass-cntrlr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _ResetEmail = TextEditingController();

  final ForgetPasswordController forgetPasswordController =
  Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xfffbeeff),
        appBar: AppBar(
          // backgroundColor: Color(0xfffbeeff),
          title: Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: Text(textAlign: TextAlign.center,
                  "Forgot password...? Don't worry just enter your email address to get a link to reset your password",
                  style: TextStyle(

                      color: Colors.black87.withOpacity(0.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ResetEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: RequiredValidator(errorText: "Email required"),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.purple)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.purple)),
                    labelStyle: TextStyle(color: Color(0xFF949494)),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.deepPurple.shade400,
                    ),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: ()async{
                  String email = _ResetEmail.text.trim();

                  if(email.isEmpty){
                    Get.snackbar("Error", "Please enter all details",snackPosition: SnackPosition.BOTTOM);
                  }else{
                    String email = _ResetEmail.text.trim();
                    forgetPasswordController.ForgetPasswordMethod(email);
                  }
                },
                child: Text('Get Link'),
              )
            ],
          ),
        )
    );
  }
}