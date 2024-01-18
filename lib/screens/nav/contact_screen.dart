import 'package:flutter/material.dart';
import 'package:flutter_number_2/screens/store/add_contact_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
