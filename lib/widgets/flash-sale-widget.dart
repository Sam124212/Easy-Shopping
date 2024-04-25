import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommreceapp/models/products-model.dart';
import 'package:ecommreceapp/screens/user-panel/product-details.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("products")
            .where("isSale", isEqualTo: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              height: Get.height / 4.5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                        productId: productData["productId"],
                        categoryId: productData["categoryId"],
                        productName: productData["productName"],
                        categoryName: productData["categoryName"],
                        salePrice: productData["salePrice"],
                        fullPrice: productData["fullPrice"],
                        productImages: productData["productImages"],
                        deliveryTime: productData["deliveryTime"],
                        isSale: productData["isSale"],
                        productDescription: productData["productDescription"],
                        createdAt: productData["createdAt"],
                        uploadAt: productData["uploadAt"]);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: ()=> Get.to(() => ProductDetails(productModel: productModel)),                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              child: FillImageCard(
                                borderRadius: 20,
                                width: Get.width / 3,
                                heightImage: Get.height / 10,
                                imageProvider: CachedNetworkImageProvider(
                                    productModel.productImages[0]
                                ),
                                title: Center(
                                  child: Text(
                                    productModel.productName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                footer: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Rs ${productModel.salePrice}",style: TextStyle(
                                        fontSize: 12
                                    ),),
                                    Text(" ${productModel.fullPrice}",style: TextStyle(
                                      fontSize: 10,
                                      color: AppConstant.appScendoryColor,
                                      decoration: TextDecoration.lineThrough
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            );
          }
          return Container();
        });
  }
}
