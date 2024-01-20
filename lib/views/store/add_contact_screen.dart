import 'package:flutter/material.dart';
import 'package:flutter_number_2/controllers/contact/contact_controller.dart';
import 'package:flutter_number_2/controllers/credentials/auth_controller.dart';
import 'package:flutter_number_2/widgets/button_primary.dart';
import 'package:flutter_number_2/widgets/button_secondary.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactController contactController = Get.put(ContactController());
    final AuthController authController = Get.put(AuthController());

    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController phoneNumberCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
        backgroundColor: app_color.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            TextFormField(
              controller: nameCtrl,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Input Name",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: phoneNumberCtrl,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Input Phone Number...",
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
                text: 'Add Contact',
                onPressed: () {
                  contactController
                      .addContact(
                    uid: authController.user.value!.uid,
                    name: nameCtrl.text,
                    phoneNumber: phoneNumberCtrl.text,
                  )
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You have successfully added a contact'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.fixed,
                      ),
                    );
                    Get.back();
                  });
                })
          ],
        ),
      ),
    );
  }
}
