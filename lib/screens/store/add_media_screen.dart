import 'package:flutter/material.dart';
import 'package:flutter_number_2/widgets/button_primary.dart';
import 'package:flutter_number_2/widgets/button_secondary.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:shared_preferences/shared_preferences.dart';

class AddMediaScreen extends StatelessWidget {
  const AddMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController phoneNumberCtrl = TextEditingController();

    Future<void> addContact(Map<String, dynamic> value) async {
      print('TESTING -> $value');
      final prefs = await SharedPreferences.getInstance();

      prefs.setStringList('contact_list', [value.toString()]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Media'),
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
            ButtonPrimary(
                color: app_color.primary,
                text: 'Add Contact',
                onPressed: () => addContact({
                      'name': nameCtrl.text,
                      'phone_number': phoneNumberCtrl.text
                    }))
          ],
        ),
      ),
    );
  }
}
