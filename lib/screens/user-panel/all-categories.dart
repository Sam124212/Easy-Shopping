import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommreceapp/models/category-model.dart';
import 'package:ecommreceapp/screens/user-panel/single-category.dart';
import 'package:ecommreceapp/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_card/image_card.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appScendoryColor,
        title: Text("All Categories",style: TextStyle(color: AppConstant.appTextColor),),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("categories").get(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
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
                child: Text("No category found"),
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
                    CategoriesModel categoriesModel = CategoriesModel(
                      categoryId: snapshot.data!.docs[index]["categoryId"],
                      categoryImg: snapshot.data!.docs[index]["categoryImg"],
                      categoryName: snapshot.data!.docs[index]["categoryName"],
                      createdAt: snapshot.data!.docs[index]["createdAt"],
                      uploadAt: snapshot.data!.docs[index]["uploadAt"],
                    );
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => AllSingleCategories(categoryId:categoriesModel.categoryId)),
                          child: Padding(padding: EdgeInsets.all(8),
                            child: Container(
                              child: FillImageCard(
                                borderRadius: 20,
                                width: Get.width / 2.3,
                                heightImage: Get.height / 10,
                                imageProvider: CachedNetworkImageProvider(categoriesModel.categoryImg),
                                title: Center(
                                  child: Text(categoriesModel.categoryName,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),),
                        )
                      ],
                    );
                  } );
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
