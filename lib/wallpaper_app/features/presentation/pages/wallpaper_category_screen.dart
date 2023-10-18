import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/wallpaper_app/builder_ids.dart';
import 'package:wallpaper_app/wallpaper_app/core/widgets/list_helper.dart';
import 'package:wallpaper_app/wallpaper_app/features/presentation/get/category_controller.dart';
import 'package:wallpaper_app/wallpaper_app/features/presentation/get/wallpaper_controller.dart';
import 'package:wallpaper_app/wallpaper_app/features/presentation/widget/wallpaper_widget.dart';

import '../../../core/enums.dart';
import '../../entities/model/photos_model.dart';
import 'wallpaper_image_view.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;

  CategorieScreen({required this.categorie});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categorie),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      ),
      body: GetBuilder<CategoryController>(
          id: wallpaperScreen,
          init: CategoryController(
              wallpaperRepo: Get.find(), category: widget.categorie),
          builder: (categoryController) {
            return categoryController.isListLoading
                ? Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListHelper(
                      isListLoading: categoryController.isListLoading,
                      hasListLoadingFailed:
                          categoryController.hasListLoadingFailed,
                      isListEmpty: categoryController.isListEmpty,
                      entityType: EntityType.choice,
                      customError: categoryController.customError,
                      loadingItems: 3,
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(4.0),
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                          children: categoryController.categoryPhotoModel
                              .map((PhotoModel photoModel) {
                            return GridTile(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageView(
                                              imgPath: photoModel.src.portrait,
                                            )));
                              },
                              child: Hero(
                                tag: photoModel.src.portrait,
                                child: Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: kIsWeb
                                          ? Image.network(
                                              photoModel.src.portrait,
                                              height: 50,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: photoModel.src.portrait,
                                              placeholder: (context, url) =>
                                                  Container(
                                                    color:
                                                        const Color(0xfff5f8fd),
                                                  ),
                                              fit: BoxFit.cover)),
                                ),
                              ),
                            ));
                          }).toList()),
                    ),
                  );
          }),
    );
  }
}
