import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';

import '../../../builder_ids.dart';
import '../../../core/enums.dart';
import '../../../core/error/errors.dart';
import '../../entities/model/photos_model.dart';
import '../../entities/repo/products_list_repo.dart';

class WallpaperController extends GetxController {
  CustomError? customError;

  final WallpaperRepo wallpaperRepo;

  WallpaperController({
    required this.wallpaperRepo,
  });

  List<PhotoModel> photoModel = [];
  List<PhotoModel> categoryPhotoModel = [];

  LoadingState listLoadingState = LoadingState.loading;
  LoadingState brandsLoadingState = LoadingState.loading;
  LoadingState categoriesLoadingState = LoadingState.loading;
  LoadingState bannersLoadingState = LoadingState.loading;

  bool get isListLoading => listLoadingState == LoadingState.loading;

  bool get isLoadingBrands => brandsLoadingState == LoadingState.loading;

  bool get hasListLoadingFailed => customError != null;

  bool get isListEmpty => photoModel.isEmpty;

  bool get isLoadingCategories =>
      categoriesLoadingState == LoadingState.loading;

  ScrollController scrollController = ScrollController();

  int noOfImageToLoad = 30;
  String category = "All";

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await reLoadWallpaper();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        reLoadWallpaper();
      }
    });
  }

  Future reLoadWallpaper() async {
    final List<Future> futures = [
      wallpaperRepo.getImagesList(noOfImageToLoad),
    ];
    try {
      final result = await Future.wait(futures);
      photoModel = result[0];
      customError = null;
    } on CustomError catch (error) {
      customError = error;
    }

    listLoadingState = LoadingState.loaded;
    update([wallpaperScreen]);
  }

  Future<void> setWallpaper() async {
    try {
      String url = "https://source.unsplash.com/random";
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
    } on PlatformException {}
  }
}
