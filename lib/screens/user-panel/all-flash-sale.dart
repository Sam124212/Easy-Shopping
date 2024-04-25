import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommreceapp/models/category-model.dart';
import 'package:ecommreceapp/models/products-model.dart';
import 'package:ecommreceapp/screens/user-panel/product-details.dart';
import 'package:ecommreceapp/screens/user-panel/single-category.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllFlashScreen extends StatefulWidget {
  const AllFlashScreen({super.key});

  @override
  State<AllFlashScreen> createState() => _AllFlashScreenState();
}

class _AllFlashScreenState extends State<AllFlashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appScendoryColor,
        title: Text("All Flash Sale Products",style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("products")
              .where("isSale", isEqualTo: true)
              .get(),
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
                child: Text("No product found"),
              );
            }
            if (snapshot.data != null) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1.19),
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
                    // CategoriesModel categoriesModel = CategoriesModel(
                    //   categoryId: snapshot.data!.docs[index]["categoryId"],
                    //   categoryImg: snapshot.data!.docs[index]["categoryImg"],
                    //   categoryName: snapshot.data!.docs[index]["categoryName"],
                    //   createdAt: snapshot.data!.docs[index]["createdAt"],
                    //   uploadAt: snapshot.data!.docs[index]["uploadAt"],
                    // );
                    return Row(
                      children: [
                        GestureDetector(
                        onTap: ()=> Get.to(() => ProductDetails(productModel: productModel)),
                    child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              child: FillImageCard(
                                borderRadius: 20,
                                width: Get.width / 2.3,
                                heightImage: Get.height / 10,
                                imageProvider: CachedNetworkImageProvider(
                                    productModel.productImages[0]),
                                title: Center(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    productModel.productName,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
              //   Container(
              //   height: Get.height / 5.5,
              //   child: ListView.builder(
              //       itemCount: snapshot.data!.docs.length,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //
              // );
            }
            return Container();
          }),
    );
  }
}
