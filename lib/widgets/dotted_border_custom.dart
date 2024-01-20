import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class DottedBorderCustom extends StatelessWidget {
  const DottedBorderCustom({
    required this.title,
    required this.onTap,
    this.media,
    this.isVideo = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final dynamic media;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        radius: const Radius.circular(10),
        dashPattern: const [8, 8],
        color: app_color.grey,
        strokeWidth: 1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: media != null
                ? isVideo
                    ? media
                    : Image.file(media)
                : Text(
                    title,
                    style: app_typo.labelText,
                    textAlign: TextAlign.center,
                    // ),
                  ),
          ),
        ),
      ),
    );
  }
}
