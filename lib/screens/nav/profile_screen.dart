import 'package:flutter/material.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final ScrollController scrollController2 = ScrollController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        controller: scrollController,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: app_color.ternary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(
              children: [
                const Icon(
                  Icons.person,
                  color: app_color.white,
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem Nama',
                      style:
                          app_typo.titleText16.copyWith(color: app_color.white),
                    ),
                    Text(
                      'Lorem Nama',
                      style:
                          app_typo.labelText.copyWith(color: app_color.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          for (var i = 0; i < 10; i++) ...[
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 2),
                decoration: const BoxDecoration(
                  color: app_color.primary,
                ),
                child: Text(
                  'Contoh',
                  style: app_typo.titleText16.copyWith(color: app_color.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
