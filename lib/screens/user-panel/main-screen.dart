import 'package:ecommreceapp/screens/user-panel/all-categories.dart';
import 'package:ecommreceapp/screens/user-panel/all-flash-sale.dart';
import 'package:ecommreceapp/screens/user-panel/all-products.dart';
import 'package:ecommreceapp/screens/user-panel/cart-screen.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:ecommreceapp/widgets/all-products-widget.dart';
import 'package:ecommreceapp/widgets/banner-widget.dart';
import 'package:ecommreceapp/widgets/category-widget.dart';
import 'package:ecommreceapp/widgets/custom-drwer-widget.dart';
import 'package:ecommreceapp/widgets/flash-sale-widget.dart';
import 'package:ecommreceapp/widgets/heading-widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          "Main Screen",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      drawer: MyDrawer_Widget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90,
              ),
              //banners
              BannerWidget(),
              BannerWidget(),
              //headings
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTap: () => Get.to(() => AllCategories()),
                buttonText: "See More >",
              ),
              CategoriesWidget(),
              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "According to your budget",
                onTap: () => Get.to(() => AllFlashScreen()),
                buttonText: "See More >",
              ),
              FlashSaleWidget(),
              HeadingWidget(
                headingTitle: "All Products",
                headingSubTitle: "According to your budget",
                onTap: () => Get.to(() => AllProductsScreen()),
                buttonText: "See More >",
              ),
              AllProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
