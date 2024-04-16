import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final ResetEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffbeeff),
        appBar: AppBar(
          backgroundColor: Color(0xfffbeeff),
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
                controller: ResetEmail,
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
                onPressed: () {
                  // resetPassword(ResetEmail.text.trim(), context);
                  //send reset password link
                },
                child: Text('Get Link'),
              )
            ],
          ),
        ));
  }
}

// Future<void> resetPassword(String email, BuildContext context) async {
//   try {
//     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//     // Password reset email sent successfully, show a confirmation message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Password reset email sent. Please check your email.'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   } catch (e) {
//     // Handle any errors that occurred during the password reset process
//     print('Error sending password reset email: $e');
//     // Show an error message to the user
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to send password reset email. Please try again.'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }