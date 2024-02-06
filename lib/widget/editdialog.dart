
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../DB/databaseinit.dart';
import '../model/userModel.dart';

class UpdataDataDialog extends StatefulWidget {
  @override
  _UpdataDataDialogState createState() => _UpdataDataDialogState();
}

class _UpdataDataDialogState extends State<UpdataDataDialog> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  void _save(context) async {
    await DatabaseHelper().initializeDatabase();
    User _user = User(
      DateFormat("yyyy-MM-dd").format(DateTime.now()),
      heightController.text.toString(),
      weightController.text.toString(),
    );

    try {
      await DatabaseHelper().updateuser(_user);
      Navigator.pop(context,true);
      print(" data saved succesfully");
    } catch (e) {
      print("erro  in data daving");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update  Data"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Height (cm)",
              prefixIcon: Icon(Icons.height),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Weight (kg)",
              prefixIcon: Icon(Icons.fitness_center),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _save(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.orange,
                ),
                child: Text("OK"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}