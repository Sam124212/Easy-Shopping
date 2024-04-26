import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommreceapp/models/order-model.dart';
import 'package:ecommreceapp/screens/user-panel/main-screen.dart';
import 'package:ecommreceapp/services/generate-order-ids.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void placeOrder({
  required String customerToken,
  required String customerAddress,
  required String customerPhone,
  required String customerName,
  required BuildContext context,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "Please wait");
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("cart")
          .doc(user.uid)
          .collection("cartOrders")
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel cartModel = OrderModel(
            productId: data["productId"],
            categoryId: data["categoryId"],
            productName: data["productName"],
            categoryName: data["categoryName"],
            salePrice: data["salePrice"],
            fullPrice: data["fullPrice"],
            productImages: data["productImages"],
            deliveryTime: data["deliveryTime"],
            isSale: data["isSale"],
            productDescription: data["productDescription"],
            createdAt: DateTime.now(),
            uploadAt: data["uploadAt"],
            productQuantity: data["productQuantity"],
            productTotalPrice:
                double.parse(data["productTotalPrice"].toString()),
            customerId: user.uid,
            status: false,
            customerName: customerName,
            customerAddress: customerAddress,
            customerPhone: customerPhone,
            customerDeviceToken: customerToken);

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection("orders")
              .doc(user.uid)
              .set({
            "uId": user.uid,
            "customerName": customerName,
            "customerPhone": customerPhone,
            "customerAddress": customerAddress,
            "customerDeviceToken": customerToken,
            "createdAt": DateTime.now(),
            "status": false,
          });

          // upload orders

          await FirebaseFirestore.instance
              .collection("orders")
              .doc(user.uid)
              .collection("confirmOrders")
              .doc(orderId)
              .set(cartModel.toMap());

          //delete cart products
          await FirebaseFirestore.instance
              .collection("cart")
              .doc(user.uid)
              .collection("cartOrders")
              .doc(cartModel.productId.toString())
              .delete()
              .then((value) {
            print("Delete cart Products $cartModel.productId.toString");
          });
        }
        print("order Confirmed");
        Get.snackbar("Order Confirmed", "Thank you for your order!",
        backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5)
        );
      }
      EasyLoading.dismiss();
      Get.offAll(()=> MainScreen());
    } catch (e) {
      print("error $e");
    }
  }
}
