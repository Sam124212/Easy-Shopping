import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommreceapp/models/cart-model.dart';
import 'package:ecommreceapp/models/products-model.dart';
import 'package:ecommreceapp/screens/user-panel/product-details.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Cart Screen"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("cart")
              .doc(user!.uid)
              .collection("cartOrders")
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
                        CartModel cartModel = CartModel(
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
                            productTotalPrice:
                                productData["productTotalPrice"]);
                        return SwipeActionCell(
                            key: ObjectKey(cartModel.productId),
                            trailingActions: [
                              SwipeAction(
                                  title: "Delete",
                                  forceAlignmentToBoundary: true,
                                  performsFirstActionWithFullSwipe: true,
                                  onTap: (CompletionHandler handler) async {
                                    print("deleted");

                                    FirebaseFirestore.instance
                                        .collection("cart")
                                        .doc(user!.uid)
                                        .collection("cartOrders")
                                        .doc(cartModel.productId)
                                        .delete();
                                  })
                            ],
                            child: Card(
                              elevation: 5,
                              color: AppConstant.appTextColor,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(cartModel.productImages[0]),
                                ),
                                title: Text(cartModel.productName),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        cartModel.productTotalPrice.toString()),
                                    SizedBox(width: Get.width / 20),
                                    GestureDetector(
                                      onTap: () async {
                                        if (cartModel.productQuantity > 1) {
                                          await FirebaseFirestore.instance
                                              .collection("cart")
                                              .doc(user!.uid)
                                              .collection("cartOrders")
                                              .doc(cartModel.productId)
                                              .update({
                                            "productQuantity":
                                                cartModel.productQuantity - 1,
                                            "productTotalPrice": (double.parse(
                                                    cartModel.fullPrice) *
                                                (cartModel.productQuantity - 1))
                                          });
                                        }
                                      },
                                      child: CircleAvatar(
                                        child: Text("-"),
                                        backgroundColor:
                                            AppConstant.appMainColor,
                                        radius: 14,
                                      ),
                                    ),
                                    SizedBox(width: Get.width / 20),
                                    GestureDetector(
                                      onTap: () async {
                                        if (cartModel.productQuantity > 0) {
                                          await FirebaseFirestore.instance
                                              .collection("cart")
                                              .doc(user!.uid)
                                              .collection("cartOrders")
                                              .doc(cartModel.productId)
                                              .update({
                                            "productQuantity":
                                                cartModel.productQuantity + 1,
                                            "productTotalPrice": double.parse(
                                                    cartModel.fullPrice) +
                                                double.parse(
                                                        cartModel.fullPrice) *
                                                    (cartModel.productQuantity)
                                          });
                                        }
                                      },
                                      child: CircleAvatar(
                                        child: Text("+"),
                                        backgroundColor:
                                            AppConstant.appMainColor,
                                        radius: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }));
            }
            return Container();
          }),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Rs 1200",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                        color: AppConstant.appScendoryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
