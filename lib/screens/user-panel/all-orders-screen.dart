import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommreceapp/controller/cart-controller.dart';
import 'package:ecommreceapp/models/cart-model.dart';
import 'package:ecommreceapp/models/order-model.dart';
import 'package:ecommreceapp/screens/user-panel/checkout-screen.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("All Orders"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .doc(user!.uid)
              .collection("confirmOrders")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: Get.height / 5,
                child: Center(child: CupertinoActivityIndicator()),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No Products found"),
              );
            }
            if (snapshot.data != null) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final productData = snapshot.data!.docs[index];
                        OrderModel orderModel = OrderModel(
                            productId: productData["productId"],
                            categoryId: productData["categoryId"],
                            productName: productData["productName"],
                            categoryName: productData["categoryName"],
                            salePrice: productData["salePrice"],
                            fullPrice: productData["fullPrice"],
                            productImages: productData["productImages"],
                            deliveryTime: productData["deliveryTime"],
                            isSale: productData["isSale"],
                            productDescription:
                                productData["productDescription"],
                            createdAt: productData["createdAt"],
                            uploadAt: productData["uploadAt"],
                            productQuantity: productData["productQuantity"],
                            productTotalPrice: double.parse(
                                productData["productTotalPrice"].toString()),
                            customerId: productData["customerId"],
                            status: productData["status"],
                            customerName: productData["customerName"],
                            customerAddress: productData["customerAddress"],
                            customerPhone: productData["customerPhone"],
                            customerDeviceToken:
                                productData["customerDeviceToken"]);

                        //calculate Price
                        productPriceController.fetchProductPrice();
                        return Card(
                          elevation: 5,
                          color: AppConstant.appTextColor,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(orderModel.productImages[0]),
                            ),
                            title: Text(orderModel.productName),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(orderModel.productTotalPrice.toString()),
                                SizedBox(
                                  width: 10,
                                ),
                                orderModel.status != true
                                    ? Text(
                                        "Pending",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : Text("Deliverd",style: TextStyle(color: Colors.red),)
                              ],
                            ),
                          ),
                        );
                      }));
            }
            return Container();
          }),
    );
  }
}
