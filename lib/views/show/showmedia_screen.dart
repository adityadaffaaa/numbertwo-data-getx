// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/media/storage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class ShowMediaScreen extends StatelessWidget {
  ShowMediaScreen({super.key});

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
          centerTitle: true,
          title: Text(Get.arguments[0]),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          backgroundColor: app_color.primary,
        ),
        body: FutureBuilder(
          future: storageController.getImagesAndVideos(Get.arguments[1]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: app_color.primary,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return snapshot.data!.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: 1),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String fileUrl = snapshot.data![index];
                        return ListTile(
                          title: Get.arguments[0] == "Image"
                              ? Image.network(fileUrl)
                              : VideoPlayerWidget(fileUrl: fileUrl),
                          leading: Text(
                            Get.arguments[0] == "Image"
                                ? "Image ${index + 1}"
                                : "Video ${index + 1}",
                            style: app_typo.titleText15,
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("Data not available!"));
            }
          },
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String fileUrl;

  const VideoPlayerWidget({Key? key, required this.fileUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.fileUrl)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
