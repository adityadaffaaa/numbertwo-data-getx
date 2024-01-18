import 'package:flutter/material.dart';
import 'package:flutter_number_2/screens/store/add_contact_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Future<void> getListContact() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.get('contact_list');
  }

  @override
  void initState() {
    // TODO: implement initState
    getListContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('Daffa'),
            trailing: Text('08123123902839'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddContactScreen();
              },
            ));
          },
          label: Row(
            children: const [Text('Add Contact'), Icon(Icons.add)],
          )),
    );
  }
}
