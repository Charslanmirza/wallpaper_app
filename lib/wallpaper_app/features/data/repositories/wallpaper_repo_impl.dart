import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/error/errors.dart';
import '../../../core/services/network_service.dart';
import '../../../core/utils/utils.dart';
import '../../entities/model/photos_model.dart';
import '../../entities/repo/products_list_repo.dart';
import '../data_source/wallpaper_remote_source.dart';

class WallpaperRepoImpl implements WallpaperRepo {
  final WallpaperRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WallpaperRepoImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<List<PhotoModel>> getImagesList(int noOfPages) async {
    // TODO: implement getImagesList
    await checkNetwork(networkInfo);

    try {
      return await remoteDataSource.getImagesList(noOfPages);
    } on GeneralError catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<List<PhotoModel>> getCategoryList(String category) async {
    // TODO: implement getCategoryList
    await checkNetwork(networkInfo);

    try {
      return await remoteDataSource.getCategoriesList(category);
    } on GeneralError catch (error) {
      return Future.error(error);
    }
  }
}