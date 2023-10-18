import 'package:get/get.dart';
import 'package:wallpaper_app/wallpaper_app/features/data/data_source/wallpaper_remote_source.dart';
import 'package:wallpaper_app/wallpaper_app/features/data/repositories/wallpaper_repo_impl.dart';
import 'package:wallpaper_app/wallpaper_app/features/entities/repo/products_list_repo.dart';



initWallpaper() {
  Get.lazyPut<WallpaperRepo>(
      () => WallpaperRepoImpl(
          remoteDataSource: Get.find(), networkInfo: Get.find()),
      fenix: true);
  Get.lazyPut<WallpaperRemoteDataSource>(
      () => WallpaperRemoteDataSourceImpl(Get.find()),
      fenix: true);
}
