import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/wallpaper_app/builder_ids.dart';

import '../../../core/enums.dart';
import '../../../core/error/errors.dart';
import '../../entities/model/photos_model.dart';
import '../../entities/repo/products_list_repo.dart';

class CategoryController extends GetxController {
  CustomError? customError;

  final WallpaperRepo wallpaperRepo;

  CategoryController({required this.wallpaperRepo, required this.category});

  List<PhotoModel> categoryPhotoModel = [];

  LoadingState listLoadingState = LoadingState.loading;
  LoadingState brandsLoadingState = LoadingState.loading;
  LoadingState categoriesLoadingState = LoadingState.loading;
  LoadingState bannersLoadingState = LoadingState.loading;

  bool get isListLoading => listLoadingState == LoadingState.loading;

  bool get isLoadingBrands => brandsLoadingState == LoadingState.loading;

  bool get hasListLoadingFailed => customError != null;

  bool get isListEmpty => categoryPhotoModel.isEmpty;

  bool get isLoadingCategories =>
      categoriesLoadingState == LoadingState.loading;

  ScrollController scrollController = ScrollController();

  int noOfImageToLoad = 30;
  String category;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategories();
    print('objecswasdasdasdasdt${categoryPhotoModel.length}');

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
      }
    });
  }

  Future getCategories() async {
    // final List<Future> futures = [
    //
    // ];
    try {
      wallpaperRepo.getCategoryList(category).then((value) {
        categoryPhotoModel = value;
        listLoadingState = LoadingState.loaded;
        update([wallpaperScreen]);
      });

      customError = null;
    } on CustomError catch (error) {
      customError = error;
    }

    listLoadingState = LoadingState.loaded;
    update([wallpaperScreen]);
  }
}
