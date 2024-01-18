import 'package:flutter/material.dart';
import 'package:flutter_number_2/screens/store/add_contact_screen.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

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
            trailing: Text('Media'),
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
            children: const [Text('Add Media'), Icon(Icons.add)],
          )),
    );
  }
}
