import 'package:ecommreceapp/controller/get-userdata-controller.dart';
import 'package:ecommreceapp/controller/sign-in-cntrlr.dart';
import 'package:ecommreceapp/screens/admin-panel/admin-main-screen.dart';
import 'package:ecommreceapp/screens/auth-ui/forgotpassword-screen.dart';
import 'package:ecommreceapp/screens/auth-ui/signup-screen.dart';
import 'package:ecommreceapp/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// enum Language { english, urdu }
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isLoader = false;
  bool _obscureText = true;
  bool _change = false;

  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext, isKeyboardVisible) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // backgroundColor: Color(0xfffbeeff),
            ),
            // backgroundColor: Color(0xfffbeeff),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        isKeyboardVisible
                            ? SizedBox.shrink()
                            : Lottie.asset("assets/lottie/1.json", width: 200),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          style: TextStyle(color: Colors.black),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Email required"),
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
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.deepPurple.shade400,
                              ),
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          controller: _passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator:
                              RequiredValidator(errorText: "Password required"),
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
                                  onPressed: () {
                                    setState(() {
                                      _change = !_change;
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: _change
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  color: _change
                                      ? Colors.deepPurple.shade900
                                      : Colors.deepPurple.shade400),
                              labelText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Bounceable(
                          onTap: () {
                            Navigator.of(context).push(PageTransition(
                                child: ForgotPassScreen(),
                                type: PageTransitionType.fade));
                          },
                          child: Text(
                            "forgot Password",
                            style: TextStyle(
                                color: Colors.deepPurple.shade500,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Bounceable(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation:
                                      MaterialStateProperty.all<double>(8.0),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Colors.deepPurple),
                                ),
                                autofocus: true,
                                onPressed: () async {
                                  String email = _emailController.text.trim();
                                  String password =
                                      _passwordController.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    Get.snackbar(
                                        "Error", "Please enter all details",
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    UserCredential? userCredential =
                                        await signInController.signInMethod(
                                            email, password);
                                    var userData = await getUserDataController
                                        .getUserData(userCredential!.user!.uid);
                                    if (userCredential != null) {
                                      if (userCredential.user!.emailVerified) {
                                        if (userData[0]["isAdmin"] == true) {
                                          Get.snackbar("Success Admin Login",
                                              "Login Successfully",
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                          Get.offAll(() => AdminMianScreen());
                                        } else {
                                          Get.offAll(() => MainScreen());
                                          Get.snackbar("Success User Login",
                                              "Login Successfully",
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        }
                                      } else {
                                        Get.snackbar(
                                            "Error", "Please verify your email",
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    } else {
                                      Get.snackbar("Error", "Please try again",
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  }
                                },
                                child: isLoader
                                    ? Center(child: CircularProgressIndicator())
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Bounceable(
                          onTap: () {
                            Navigator.of(context).push(PageTransition(
                                child: SighnUpPage(),
                                type: PageTransitionType.fade));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("don't have account?  "),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.deepPurple.shade500,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
