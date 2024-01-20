import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/data/data_controller.dart';
import 'package:flutter_number_2/widgets/button_primary.dart';
import 'package:flutter_number_2/widgets/button_secondary.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dataCtrl = TextEditingController();

    final DataController dataController = Get.put(DataController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        backgroundColor: app_color.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            TextFormField(
              controller: dataCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Input Data",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonPrimary(
              color: app_color.primary,
              text: 'Add Data',
              onPressed: () {
                dataController.setData(dataCtrl.text).then((value) {
                  Get.back();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
