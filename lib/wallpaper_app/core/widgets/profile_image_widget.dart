import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/wallpaper_app/core/utils/validators.dart';

import 'network_image_loader.dart';

/// This widget is built on top of [ProfileImageWidget], and enables
/// error messages in case the [image] is not null. This functionality
/// is decided by [validate] param.
///
class ProfileImageField extends FormField<File> {
  final File? image;
  final bool validate;

  ProfileImageField({super.key, this.image, this.validate = true})
      : super(
            initialValue: image,
            validator: validate ? DynamicFieldValidator.validator : null,
            builder: (state) {
              return Column(
                children: [
                  ProfileImageWidget(
                    imageFile: image,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  if (state.hasError) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Builder(
                            builder: (context) => Text(
                                  state.errorText ?? "Validation Error",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red),
                                )),
                      ],
                    ),
                  ],
                ],
              );
            });
}

/// Uses [NetworkImageLoader] and [Image.file] to display user's image,
/// from [imageUrl] and [imageFile] respectively.
/// If both of the image sources are null, an [Icon] is displayed.
/// The profile icon is set according to the signup screen, because it
/// will only be displayed on [UserRegisterPage], that uses
/// [ProfileImageField], that is built on top of this widget
class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {Key? key, this.imageFile, this.imageUrl, this.onTap})
      : super(key: key);

  final File? imageFile;
  final String? imageUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double longestSide = screenSize.longestSide;

    // Calculate the width based on the screen's longest side
    double containerSize = longestSide * 0.30; // Adjust this factor as needed
    containerSize =
        containerSize.clamp(80, 90); // Clamp the value between 50 and 120
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: Stack(
        children: [
          Container(
              height: containerSize,
              width: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiary,
                // image: DecorationImage(
                //   fit: imageUrl != null || imageFile != null ? BoxFit.cover : BoxFit.scaleDown,
                //   image: ,
                // ),
              ),
              clipBehavior: Clip.hardEdge,
              child: imageUrl != null || imageFile != null
                  ? imageUrl != null
                      ? imageUrl!.isNotEmpty
                          ? NetworkImageLoader(
                              imageUrl: imageUrl!,
                              progressType: ImageProgressType.circular,

                            )
                          : const Icon(
                              Icons.person,
                              size: 80.0,
                              color: Colors.black,
                            )
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                  : const Icon(
                      Icons.add_a_photo_outlined,
                      size: 50.0,
                      color: Colors.blueGrey,
                    )
              // Image.asset(AppAssets.icon_person, fit: BoxFit.scaleDown),
              ),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(width: 3, color: Colors.white)),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              )),
          // Center(
          //   child: Stack(
          //     children: [
          //       Container(
          //         width: 130,
          //         height: 130,
          //         decoration: BoxDecoration(
          //             border: Border.all(
          //                 width: 4,
          //                 color: Theme.of(context).scaffoldBackgroundColor),
          //             boxShadow: [
          //               BoxShadow(
          //                   spreadRadius: 2,
          //                   blurRadius: 5,
          //                   color: Colors.black.withOpacity(0.1),
          //                   offset: Offset(0, 10))
          //             ],
          //             shape: BoxShape.circle,
          //             image: DecorationImage(
          //                 fit: BoxFit.cover,
          //                 image: NetworkImage(
          //                   "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
          //                 ))),
          //       ),
          //       Positioned(
          //           bottom: 0,
          //           right: 0,
          //           child: Container(
          //             height: 40,
          //             width: 40,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               border: Border.all(
          //                 width: 4,
          //                 color: Theme.of(context).scaffoldBackgroundColor,
          //               ),
          //               color: Colors.green,
          //             ),
          //             child: Icon(
          //               Icons.edit,
          //               color: Colors.white,
          //             ),
          //           )),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
