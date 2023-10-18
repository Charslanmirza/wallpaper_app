import 'package:get/get.dart';

import 'wallpaper_app/features/presentation/get/wallpaper_controller.dart';
import 'wallpaper_app/init_wallpaper.dart';

initAll() {
  initWallpaper();
}

removeAll() {
  Get.delete<WallpaperController>();
}
