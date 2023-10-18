import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/wallpaper_app/features/entities/model/category_model.dart';
import 'package:wallpaper_app/wallpaper_app/features/presentation/pages/search_view.dart';
import 'package:wallpaper_app/wallpaper_app/features/presentation/pages/wallpaper_category_screen.dart';

import '../../../builder_ids.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../data/category_source.dart';
import '../get/wallpaper_controller.dart';
import '../widget/wallpaper_widget.dart';

class WallpaperHomePage extends StatefulWidget {
  @override
  _WallpaperHomePageState createState() => _WallpaperHomePageState();
}

class _WallpaperHomePageState extends State<WallpaperHomePage> {
  // List<CategorieModel> categories = new List();
  //
  // int noOfImageToLoad = 30;
  // List<PhotosModel> photos = new List();

  // getTrendingWallpaper() async {
  //   await http.get(
  //       "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
  //       headers: {"Authorization": apiKEY}).then((value) {
  //     //print(value.body);
  //
  //     Map<String, dynamic> jsonData = jsonDecode(value.body);
  //     jsonData["photos"].forEach((element) {
  //       //print(element);
  //       PhotosModel photosModel = new PhotosModel();
  //       photosModel = PhotosModel.fromMap(element);
  //       photos.add(photosModel);
  //       //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
  //     });
  //
  //     setState(() {});
  //   });
  // }

  TextEditingController searchController = new TextEditingController();

  List<CategoryModel> categories = [];

  @override
  void initState() {
    //getWallpaper();
    // getTrendingWallpaper();
    // categories = getCategories();
    super.initState();
    categories = getCategories();
    //
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     noOfImageToLoad = noOfImageToLoad + 30;
    //     getTrendingWallpaper();
    //   }
    // });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.appLogo, width: 200),
        elevation: 1,
        centerTitle: true,
        shadowColor: Colors.grey.withOpacity(.5),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<WallpaperController>(
          id: wallpaperScreen,
          init: WallpaperController(wallpaperRepo: Get.find()),
          builder: (wallpaperController) {
            print('object${wallpaperController.photoModel.length}');
            return wallpaperController.isListLoading
                ? Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      if (searchController.text != "") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchView(
                                                      search:
                                                          searchController.text,
                                                    )));
                                      }
                                    },
                                    child: Container(
                                        child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ))),
                                hintText: "search wallpapers",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Made By ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL(
                                    "https://www.linkedin.com/in/lamsanskar/");
                              },
                              child: Container(
                                  child: const Text(
                                "Arslan Mirza",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontFamily: 'Overpass'),
                              )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 80,
                          child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              itemCount: categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var item = categories[index];

                                /// Create List Item tile
                                return CategoriesTile(
                                  imgUrls: item.img!,
                                  categorie: item.name!,
                                );
                              }),
                        ),
                        // wallPaper(photos, context),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Photos provided By ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            ),
                            GestureDetector(
                              onTap: () {
                                // _launchURL("https://www.pexels.com/");
                                wallpaperController.setWallpaper();
                              },
                              child: Container(
                                  child: const Text(
                                "Pexels",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontFamily: 'Overpass'),
                              )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        wallPaper(wallpaperController.photoModel,
                            wallpaperController, context)
                      ],
                    ),
                  );
          }),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  CategoriesTile({required this.imgUrls, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategorieScreen(
                      categorie: categorie,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        categorie,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Overpass'),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                      height: 200,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text(
                        categorie ?? "Yo Yo",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Overpass'),
                      ))
                ],
              ),
      ),
    );
  }
}
