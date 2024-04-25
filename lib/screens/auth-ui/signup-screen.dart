import 'package:ecommreceapp/controller/signup-contrlr.dart';
import 'package:ecommreceapp/screens/auth-ui/login-screen.dart';
import 'package:ecommreceapp/screens/auth-ui/welcome-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


class SighnUpPage extends StatefulWidget {
  SighnUpPage({super.key});

  @override
  State<SighnUpPage> createState() => _SighnUpPageState();
}

class _SighnUpPageState extends State<SighnUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();
  // var authService = AuthService();
  var isLoader = false;
  bool _obscureText = true;
  bool _change = false;
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xfffbeeff),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Lottie.asset("assets/lottie/1.json",width: 220),
                TextFormField(
                  controller: _userNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: RequiredValidator(errorText: "Username required"),
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
                      suffixIcon: Icon(Icons.person, color: Colors.deepPurple.shade400),
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Email requird"),
                    EmailValidator(errorText: "Not valid email"),
                  ]),
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
                      suffixIcon:
                      Icon(Icons.email_outlined, color: Colors.deepPurple.shade400),
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                  RequiredValidator(errorText: "Phone number required"),
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
                      suffixIcon:
                      Icon(Icons.phone, color: Colors.deepPurple.shade400),
                      labelText: "Phone",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _cityController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                  RequiredValidator(errorText: "City name required"),
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
                      suffixIcon:
                      Icon(Icons.location_on, color: Colors.deepPurple.shade400),
                      labelText: "City",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                  RequiredValidator(errorText: "Password Required"),
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
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _change =! _change;
                              _obscureText =! _obscureText;
                            });
                          },icon: _change?Icon(Icons.visibility):Icon(Icons.visibility_off),
                          color: _change? Colors.deepPurple.shade900 : Colors.deepPurple.shade400),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                SizedBox(
                  height: 40,
                ),
                Bounceable(
                  onTap: (){},
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(8.0),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                        ),
                        onPressed: () async{
                          String name = _userNameController.text.trim();
                          String email = _emailController.text.trim();
                          String phone = _phoneNumberController.text.trim();
                          String city = _cityController.text.trim();
                          String password = _passwordController.text.trim();
                          String userDeviceToken = " ";
                          if(name.isEmpty || email.isEmpty || phone.isEmpty || city.isEmpty || password.isEmpty){
                            Get.snackbar("Error", "Enetr All Details",snackPosition: SnackPosition.BOTTOM);
                          }else{
                            UserCredential? userCredential = await signUpController.signUpMethod(
                                name, email, phone, city, password, userDeviceToken);
                            if(userCredential != null){
                              Get.snackbar(
                                  "Varification Email sent",
                                  "Please check your email",
                                  snackPosition: SnackPosition.BOTTOM);
                              FirebaseAuth.instance.signOut();
                              Get.offAll(()=>LoginPage());

                            }
                          }
                        },
                        child: isLoader
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                          "SIGN UP",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account?  "),
                    Bounceable(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(child: LoginPage(),
                            type: PageTransitionType.fade));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.deepPurple.shade500,
                            fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}