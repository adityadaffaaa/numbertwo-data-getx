import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<File?> videoFile = Rx<File?>(null);
  Rx<Image?> videoThumbnail = Rx<Image?>(null);

  Future<void> pickImage({bool isCamera = false}) async {
    final pickedFile = await _imagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> pickVideoFromGallery() async {
    final pickedFile =
        await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile.value = File(pickedFile.path);
    }
  }

  Future<void> pickVideoAndGenerateThumbnail() async {
    final pickedFile =
        await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      File videoFile = File(pickedFile.path);
      this.videoFile.value = videoFile;
      await generateVideoThumbnail(videoFile);
    }
  }

  Future<void> generateVideoThumbnail(File videoFile) async {
    final uint8list = await VideoThumbnail.thumbnailData(
        video: videoFile.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 256,
        quality: 100);

    Image thumbnailImage = Image.memory(Uint8List.fromList(uint8list!));
    videoThumbnail.value = thumbnailImage;
  }
}
