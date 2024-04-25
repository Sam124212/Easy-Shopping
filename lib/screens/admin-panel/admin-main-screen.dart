import 'package:flutter/material.dart';
class AdminMianScreen extends StatefulWidget {
  const AdminMianScreen({super.key});

  @override
  State<AdminMianScreen> createState() => _AdminMianScreenState();
}

class _AdminMianScreenState extends State<AdminMianScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel"),),
    );
  }
}
