import 'package:ecommreceapp/screens/auth-ui/login-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:io';
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
  final _passwordController = TextEditingController();
  // var authService = AuthService();
  var isLoader = false;
  bool _obscureText = true;
  bool _change = false;

  // final picker = ImagePicker();
  File? _pickedImage;
  String? _profileImageUrl;

  // Future<void> _SubmitForm() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       isLoader = true;
  //     });
  //
  //     // String? imageUrl = await uploadImageToFirebase();
  //
  //     // if (imageUrl != null) {
  //     var data = {
  //       "username": _userNameController.text,
  //       "email": _emailController.text,
  //       "password": _passwordController.text,
  //       "phone": _phoneNumberController.text,
  //       "remainingAmount": 0,
  //       "totalIncome": 0,
  //       "totalExpense": 0,
  //       // "profileImageUrl": imageUrl,
  //     };
  //
  //     await authService.createUser(data, context);
  //     await auth.currentUser?.updateDisplayName(_userNameController.text);
  //
  //
  //     setState(() {
  //       isLoader = false;
  //     });
  //   }
  // }
  // Future<String?> uploadImageToFirebase() async {
  //   try {
  //     final Reference storageReference =
  //     firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('profile_images')
  //         .child('${auth.currentUser?.uid}.jpg');
  //
  //     await storageReference.putFile(_pickedImage!);
  //
  //     final String imageUrl = await storageReference.getDownloadURL();
  //     return imageUrl;
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffbeeff),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Create new Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurple.shade500,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Image.asset("assets/images/1.png",width: 100,color: Colors.deepPurple.shade500,),
                  ),
                  // CircleAvatar(
                  //   radius: 50,
                  //   backgroundImage: _pickedImage != null
                  //       ? FileImage(_pickedImage!)
                  //       : null,
                  //   child: IconButton(
                  //     onPressed: () async {
                  //       final pickedFile =
                  //       await picker.pickImage(source: ImageSource.gallery);
                  //       if (pickedFile != null) {
                  //         setState(() {
                  //           _pickedImage = File(pickedFile.path);
                  //         });
                  //       }
                  //     },
                  //     icon: Center(
                  //       child: Stack(
                  //         children: [
                  //           Icon(
                  //             Icons.add,
                  //             size: 40,
                  //             color: Colors.deepPurple.shade400,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //
                  SizedBox(
                    height: 16,
                  ),
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
                          onPressed: () {
                            // isLoader ? print("Loading") : _SubmitForm();
                          },
                          child: isLoader
                              ? Center(child: CircularProgressIndicator())
                              : Text(
                            "Create",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Bounceable(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(child: LoginPage(),
                          type: PageTransitionType.fade));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.deepPurple.shade500,
                          fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}