import 'package:flutter/material.dart';
import 'package:flutter_number_2/screens/store/add_contact_screen.dart';
import 'package:flutter_number_2/screens/store/add_data_screeen.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

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
            trailing: Text('Data'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddDataScreen();
              },
            ));
          },
          label: Row(
            children: const [Text('Add Data'), Icon(Icons.add)],
          )),
    );
  }
}
