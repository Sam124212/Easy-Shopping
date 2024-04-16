import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:flutter/material.dart';
class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        title: Text("hello"),
      ),
    );
  }
}
