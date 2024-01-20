import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/contact/contact_controller.dart';
import 'package:flutter_number_2/controllers/credentials/auth_controller.dart';
import 'package:flutter_number_2/views/store/add_contact_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final ContactController contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: authController.isUserLoggedIn.value
          ? StreamBuilder<QuerySnapshot<Object?>>(
              stream: contactController.getContacts(
                  uid: authController.user.value!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return snapshot.data!.docs.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 1,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data?.docs[index].data()
                                as Map<String, dynamic>;
                            debugPrint("HASILNYA -> ${data}");
                            final dataId = snapshot.data?.docs[index].id;
                            return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                        "${data['name']} - ${data['phoneNumber']}"),
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    contactController.deleteContact(
                                        id: dataId!);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: app_color.red,
                                  ),
                                ));
                          },
                        )
                      : const Center(child: Text("Data not available!"));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: app_color.primary,
                    ),
                  );
                }
              },
            )
          : const Center(
              child: Text("Sign In First!"),
            ),
      floatingActionButton: authController.isUserLoggedIn.value
          ? FloatingActionButton.extended(
              backgroundColor: app_color.primary,
              onPressed: () => Get.to(const AddContactScreen()),
              label: Row(
                children: const [Text('Add Contact'), Icon(Icons.add)],
              ))
          : null,
    );
  }
}
