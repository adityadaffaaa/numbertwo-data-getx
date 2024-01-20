import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/data/data_controller.dart';
import 'package:flutter_number_2/views/store/add_contact_screen.dart';
import 'package:flutter_number_2/views/store/add_data_screeen.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:get/get.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());

    return Scaffold(
      body: Obx(() => dataController.dataList.value.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                );
              },
              itemCount: dataController.dataList.value.length,
              itemBuilder: (context, index) {
                final data = dataController.dataList[index];
                return ListTile(
                  title: Text(data),
                );
              },
            )
          : Center(child: Text("Data not available!"))),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: app_color.primary,
          onPressed: () {
            Get.to(const AddDataScreen());
          },
          label: Row(
            children: const [Text('Add Data'), Icon(Icons.add)],
          )),
    );
  }
}
