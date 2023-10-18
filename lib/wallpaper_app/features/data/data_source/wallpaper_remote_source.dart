import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/error/errors.dart';
import '../../entities/model/photos_model.dart';

abstract class WallpaperRemoteDataSource {
  Future<List<PhotoModel>> getImagesList(int noOfPages);

  Future<List<PhotoModel>> getCategoriesList(String category);
}

class WallpaperRemoteDataSourceImpl implements WallpaperRemoteDataSource {
  final Dio _dio;

  WallpaperRemoteDataSourceImpl(this._dio);

  @override
  Future<List<PhotoModel>> getImagesList(int noOfPages) async {
    final response = await _dio.get(
        'https://api.pexels.com/v1/curated?per_page=$noOfPages',
        options: Options(headers: {"Authorization": AppUrls.apiKey}));
    // customLog(url: 'apiKey', body: {"params"}, response: response.data);

    // Map<String, dynamic> decodedJson = jsonDecode(response.data);

    if (response.statusCode != 200) {
      return Future.error(
        GeneralError(
            title: 'Products List',
            message: 'An error occurred while fetching products list.'),
      );
    }
    // if (!response.data['result']['status']) {
    //   return Future.error(GeneralError(message: response.data['message']));
    // }
    return response.data['photos']
        .map<PhotoModel>((internalTransferResponse) =>
            PhotoModel.fromJson(internalTransferResponse))
        .toList();
  }

  @override
  Future<List<PhotoModel>> getCategoriesList(String category) async {
    final response = await _dio.get(
        'https://api.pexels.com/v1/search?query=${category}&per_page=30',
        options: Options(headers: {"Authorization": AppUrls.apiKey}));
    //customLog(url: 'apiKey', body: {"params"}, response: response.data);

    if (response.statusCode != 200) {
      return Future.error(
        GeneralError(
            title: 'Products List',
            message: 'An error occurred while fetching products list.'),
      );
    }
    // if (!response.data['result']['status']) {
    //   return Future.error(GeneralError(message: response.data['message']));
    // }
    return response.data['photos']
        .map<PhotoModel>((internalTransferResponse) =>
            PhotoModel.fromJson(internalTransferResponse))
        .toList();
  }
}
