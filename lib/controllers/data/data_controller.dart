import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  RxList<String> dataList = <String>[].obs;

  Future<void> setData(String newData) async {
    dataList.add(newData);
    store();
  }

  void store() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('data_list_key', dataList.toList());
  }

  Future<void> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataList.assignAll(prefs.getStringList('data_list_key') ?? []);
  }
}
