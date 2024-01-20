import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/credentials/auth_controller.dart';
import 'package:flutter_number_2/controllers/media/media_controller.dart';
import 'package:flutter_number_2/controllers/media/storage_controller.dart';
import 'package:flutter_number_2/widgets/button_primary.dart';
import 'package:flutter_number_2/widgets/button_secondary.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:flutter_number_2/widgets/dotted_border_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class AddMediaScreen extends StatelessWidget {
  AddMediaScreen({super.key});

  final MediaController mediaController = Get.put(MediaController());
  final StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Media'),
            backgroundColor: app_color.primary,
          ),
          body: Obx(
            () => storageController.isLoading.value
                ? Center(
                    child: SizedBox(
                      height: 60,
                      child: Column(
                        children: const [
                          CircularProgressIndicator(
                            color: app_color.primary,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Wait a moment until loading is complete...")
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: ListView(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Image",
                                style: app_typo.titleText16,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Obx(() => DottedBorderCustom(
                                    title: "Insert Your Image",
                                    media: mediaController.imageFile.value,
                                    onTap: () async {
                                      Get.bottomSheet(
                                        const CustomBS(),
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ).then((value) async {
                                        await mediaController.pickImage(
                                            isCamera: value);
                                      });
                                    },
                                  )),
                            ]),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Video",
                              style: app_typo.titleText16,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Obx(() => DottedBorderCustom(
                                  title: "Insert Your Video",
                                  isVideo: true,
                                  media: mediaController.videoThumbnail.value,
                                  onTap: () async {
                                    await mediaController
                                        .pickVideoAndGenerateThumbnail();
                                  },
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ButtonPrimary(
                            color: app_color.primary,
                            text: 'Add Media',
                            onPressed: uploadMedia)
                      ],
                    ),
                  ),
          ),
        ));
  }

  Future<void> uploadMedia() async {
    if (mediaController.videoFile.value != null &&
        mediaController.imageFile.value != null) {
      String? imageDownloadURL = await storageController.uploadImage(
          mediaController.imageFile.value!, 'images');
      String? videoDownloadURL = await storageController.uploadVideo(
          mediaController.videoFile.value!, 'videos');

      if (videoDownloadURL != null && imageDownloadURL != null) {
        debugPrint('Image uploaded: $imageDownloadURL');
        debugPrint('Video uploaded: $videoDownloadURL');
        mediaController.videoFile.value = null;
        mediaController.imageFile.value = null;
        mediaController.videoThumbnail.value = null;
        Get.back();
      }
    } else if (mediaController.videoFile.value != null) {
      debugPrint("HASIL -> ${mediaController.videoFile.value!}");
      String? videoDownloadURL = await storageController.uploadVideo(
          mediaController.videoFile.value!, 'videos');

      if (videoDownloadURL != null) {
        debugPrint('Video uploaded: $videoDownloadURL');
        mediaController.videoFile.value = null;
        mediaController.videoThumbnail.value = null;

        Get.back();
      }
    } else if (mediaController.imageFile.value != null) {
      debugPrint("HASIL -> ${mediaController.imageFile.value!}");
      String? imageDownloadUrl = await storageController.uploadImage(
          mediaController.imageFile.value!, 'images');
      if (imageDownloadUrl != null) {
        debugPrint('Video uploaded: $imageDownloadUrl');
        mediaController.imageFile.value = null;
        Get.back();
      }
    } else {
      Get.snackbar("Error!", "Enter One Of The Files",
          backgroundColor: app_color.red, colorText: app_color.white);
    }
  }
}

class CustomBS extends StatelessWidget {
  const CustomBS({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                navigator!.pop(true);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: app_color.primary,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera,
                      color: app_color.white,
                    ),
                    Text(
                      "Camera",
                      style:
                          app_typo.titleText16.copyWith(color: app_color.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                navigator!.pop(false);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: app_color.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.filter_frames),
                    Text(
                      "Gallery",
                      style: app_typo.titleText16,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
