import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> contactList = <Map<String, dynamic>>[].obs;
  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  Future<void> addContact({
    required String uid,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      isLoading.value = true;
      await contacts.add({
        'userId': uid,
        'name': name,
        'phoneNumber': phoneNumber,
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      const String errMessage = 'Add Contact failed!';
      debugPrint("$errMessage -> $e");
      Get.snackbar(
        errMessage,
        e.toString(),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Stream<QuerySnapshot<Object?>> getContacts({required String uid}) {
    try {
      Stream<QuerySnapshot<Object?>> res =
          contacts.where('userId', isEqualTo: uid).snapshots();
      return res;
    } catch (e) {
      const String errMessage = 'Get Contacts Failed!';
      debugPrint("$errMessage -> $e");
      Get.snackbar(
        errMessage,
        e.toString(),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
        colorText: const Color(0xFFFFFFFF),
      );
      return const Stream.empty();
    }
  }

  Future deleteContact({required String id}) async {
    DocumentReference contacsRef = contacts.doc(id);

    contacsRef.delete();
  }
}
