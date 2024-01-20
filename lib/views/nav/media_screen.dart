import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/credentials/auth_controller.dart';
import 'package:flutter_number_2/views/show/showmedia_screen.dart';
import 'package:flutter_number_2/views/store/add_contact_screen.dart';
import 'package:flutter_number_2/views/store/add_media_screen.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:get/get.dart';

class MediaScreen extends StatelessWidget {
  MediaScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: authController.isUserLoggedIn.value
            ? ListView(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(ShowMediaScreen(),
                          arguments: ["Image", "images/"]);
                    },
                    child: ListTile(
                      tileColor: app_color.secondary,
                      leading: const Icon(
                        Icons.photo,
                        size: 38,
                        color: app_color.white,
                      ),
                      title: Text(
                        'Foto',
                        style: app_typo.titleText16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ShowMediaScreen(),
                          arguments: ["Video", "videos/"]);
                    },
                    child: ListTile(
                      tileColor: app_color.secondary,
                      leading: const Icon(
                        Icons.video_camera_back,
                        size: 38,
                        color: app_color.white,
                      ),
                      title: Text(
                        'Video',
                        style: app_typo.titleText16,
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: Text("Sign In First!"),
              ),
        floatingActionButton: authController.isUserLoggedIn.value
            ? FloatingActionButton.extended(
                onPressed: () => Get.to(AddMediaScreen()),
                backgroundColor: app_color.primary,
                label: Row(
                  children: const [Text('Add Media'), Icon(Icons.add)],
                ))
            : null);
  }
}
