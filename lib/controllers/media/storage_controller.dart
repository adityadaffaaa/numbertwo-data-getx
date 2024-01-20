import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:get/get.dart';

class StorageController extends GetxController {
  Rx<bool> isLoading = false.obs;

  Future<String?> uploadImage(File imageFile, String folderName) async {
    try {
      isLoading.value = true;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('$folderName/$fileName.jpg');

      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();
      isLoading.value = false;
      return downloadURL;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error uploading image: $e');
      Get.snackbar("Error!", e.toString(),
          backgroundColor: app_color.red, colorText: app_color.white);
      return null;
    }
  }

  Future<String?> uploadVideo(File videoFile, String folderName) async {
    try {
      isLoading.value = true;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('$folderName/$fileName.mp4');

      await ref.putFile(videoFile);
      String downloadURL = await ref.getDownloadURL();
      isLoading.value = false;
      return downloadURL;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error uploading video: $e');
      Get.snackbar("Error!", e.toString(),
          backgroundColor: app_color.red, colorText: app_color.white);
      return null;
    }
  }

  Future<List<String>> getImagesAndVideos(String file) async {
    List<String> fileList = [];
    try {
      firebase_storage.ListResult result =
          await firebase_storage.FirebaseStorage.instance.ref(file).listAll();

      for (firebase_storage.Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        fileList.add(downloadUrl);
      }
      return fileList;
    } catch (error) {
      debugPrint('Error getting images and videos: $error');
      return fileList;
    }
  }
}
