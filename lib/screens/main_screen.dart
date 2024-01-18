import 'package:flutter/material.dart';
import 'package:flutter_number_2/screens/credentials/login_screen.dart';
import 'package:flutter_number_2/screens/nav/contact_screen.dart';
import 'package:flutter_number_2/screens/nav/data_screen.dart';
import 'package:flutter_number_2/screens/nav/location_screen.dart';
import 'package:flutter_number_2/screens/nav/media_screen.dart';
import 'package:flutter_number_2/screens/nav/profile_screen.dart';
import 'package:flutter_number_2/widgets/custom_appbar.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNav() {
      return BottomNavigationBar(
          backgroundColor: app_color.white,
          currentIndex: selectedIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Icon(Icons.menu,
                        color: selectedIndex == 0
                            ? app_color.primary
                            : app_color.grey.withOpacity(0.7))),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.location_on_sharp,
                      color: selectedIndex == 1
                          ? app_color.primary
                          : app_color.grey.withOpacity(0.7),
                    )),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.phone,
                      color: selectedIndex == 2
                          ? app_color.primary
                          : app_color.grey.withOpacity(0.7),
                    )),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.file_copy,
                      color: selectedIndex == 3
                          ? app_color.primary
                          : app_color.grey.withOpacity(0.7),
                    )),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: selectedIndex == 4
                          ? app_color.primary
                          : app_color.grey.withOpacity(0.7),
                    )),
                label: ''),
          ]);
    }

    String titleAppBarConditions() {
      const title = ['Data', 'Map', 'Contact', 'Media'];
      return title[selectedIndex];
    }

    Widget screenConditions() {
      const title = [
        DataScreen(),
        LocationScreen(),
        ContactScreen(),
        MediaScreen(),
        LoginScreen()
      ];
      return title[selectedIndex];
    }

    return Scaffold(
      backgroundColor: app_color.white,
      appBar: selectedIndex == 4
          ? null
          : customAppBar(
              context,
              selectedIndex == 2 || selectedIndex == 0 ? false : true,
              titleAppBarConditions()),
      bottomNavigationBar: bottomNav(),
      body: screenConditions(),
    );
  }
}
