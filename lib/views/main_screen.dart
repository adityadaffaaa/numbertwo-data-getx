import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/credentials/auth_controller.dart';
import 'package:flutter_number_2/views/nav/profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_number_2/controllers/nav/bottom_nav_controller.dart';
import 'package:flutter_number_2/views/credentials/login_screen.dart';
import 'package:flutter_number_2/views/nav/contact_screen.dart';
import 'package:flutter_number_2/views/nav/data_screen.dart';
import 'package:flutter_number_2/views/nav/location_screen.dart';
import 'package:flutter_number_2/views/nav/media_screen.dart';
import 'package:flutter_number_2/widgets/custom_appbar.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  final AuthController authController = Get.put(AuthController());

  final List<Widget> pages = [
    DataScreen(),
    const LocationScreen(),
    ContactScreen(),
    MediaScreen(),
    const LoginScreen(),
  ];

  String titleAppBarConditions() {
    const title = ['Data', 'Map', 'Contact', 'Media', 'Profile'];
    return title[bottomNavController.currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      initState: (_) {},
      builder: (_) {
        return Obx(
          () => Scaffold(
              backgroundColor: app_color.white,
              appBar: bottomNavController.currentIndex == 4 &&
                      !authController.isUserLoggedIn.value
                  ? null
                  : customAppBar(context, titleAppBarConditions()),
              bottomNavigationBar: CustomBottomNavBar(),
              body: authController.isUserLoggedIn.value &&
                      bottomNavController.currentIndex == 4
                  ? ProfileScreen()
                  : pages[bottomNavController.currentIndex]),
        );
      },
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    Key? key,
  }) : super(key: key);

  final bottomNavGet = Get.find<BottomNavController>();
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: app_color.white,
        selectedItemColor: app_color.primary,
        unselectedItemColor: app_color.grey.withOpacity(0.7),
        currentIndex: bottomNavGet.currentIndex,
        onTap: (value) => bottomNavGet.changePage(value),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          bottomNavItem(icon: Icons.home),
          bottomNavItem(
            icon: Icons.location_on_sharp,
          ),
          bottomNavItem(
            icon: Icons.phone,
          ),
          bottomNavItem(icon: Icons.file_copy),
          bottomNavItem(icon: Icons.person_outline_outlined),
        ]);
  }

  BottomNavigationBarItem bottomNavItem({
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
        icon:
            Container(margin: const EdgeInsets.only(top: 8), child: Icon(icon)),
        label: '');
  }
}
