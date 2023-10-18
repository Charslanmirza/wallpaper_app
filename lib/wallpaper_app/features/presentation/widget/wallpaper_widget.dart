import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/enums.dart';
import '../../../core/widgets/list_helper.dart';
import '../../entities/model/photos_model.dart';
import '../get/wallpaper_controller.dart';
import '../pages/wallpaper_image_view.dart';

Widget wallPaper(List<PhotoModel> listPhotos,
    WallpaperController wallpaperController, BuildContext context) {
  print('object ${listPhotos.length}');
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListHelper(
      isListLoading: wallpaperController.isListLoading,
      hasListLoadingFailed: wallpaperController.hasListLoadingFailed,
      isListEmpty: wallpaperController.isListEmpty,
      entityType: EntityType.choice,
      customError: wallpaperController.customError,
      loadingItems: 3,
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          children: listPhotos.map((PhotoModel photoModel) {
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
                              placeholder: (context, url) => Container(
                                    color: const Color(0xfff5f8fd),
                                  ),
                              fit: BoxFit.cover)),
                ),
              ),
            ));
          }).toList()),
    ),
  );
}

Widget brandName() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "Hub",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}
