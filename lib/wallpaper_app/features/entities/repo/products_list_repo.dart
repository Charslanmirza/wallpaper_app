

import 'package:wallpaper_app/wallpaper_app/features/entities/model/photos_model.dart';

abstract class WallpaperRepo {
  Future<List<PhotoModel>> getImagesList(int noOfPages);

  Future<List<PhotoModel>> getCategoryList(String category);
}
