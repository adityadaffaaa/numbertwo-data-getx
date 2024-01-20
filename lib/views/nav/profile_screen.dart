import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/credentials/auth_controller.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:flutter_number_2/widgets/button_primary.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
          child: Column(
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(authController.user.value!.photoURL ?? ''),
            radius: 40,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            authController.user.value!.displayName.toString(),
            style: app_typo.titleText18,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            authController.user.value!.email.toString(),
            style: app_typo.labelText,
          ),
          const SizedBox(
            height: 8,
          ),
          ButtonPrimary(
              color: app_color.red,
              text: 'Log Out',
              onPressed: () => authController.signOut())
        ],
      )),
    );
  }
}
