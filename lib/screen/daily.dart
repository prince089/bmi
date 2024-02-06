import 'package:jeetbmi/DB/databaseinit.dart';
import 'package:jeetbmi/asset/string.dart';
import 'package:jeetbmi/widget/customTextFormFiled.dart';
import 'package:jeetbmi/widget/editdialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import '../model/userModel.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.dailypageTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarPickerDemo(),
    );
  }
}

class CalendarPickerDemo extends StatefulWidget {
  @override
  _CalendarPickerDemoState createState() => _CalendarPickerDemoState();
}

class _CalendarPickerDemoState extends State<CalendarPickerDemo> {
  bool isDataLoaded = false;
  late List<Map<String, dynamic>> userDataList;
  DateTime _selectedDate = DateTime.now();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    isDataLoaded = false;
    userDataList = (await DatabaseHelper().getRecords());
    print("+++++");
    isDataLoaded = true;
    setState(() {});
  }

  updatedata(User user) async {
    await DatabaseHelper().initializeDatabase();
    await DatabaseHelper().updateuser(user);
    await getUserData();
  }

  void _showAddDataDialog(
    context,
  ) async {
    bool dataUpdated = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdataDataDialog();
      },
    );

    if (dataUpdated != null && dataUpdated) {
      // Data is updated, rebuild the state or perform any necessary actions
      await getUserData();
      // Call your method to update the data in the profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.dailypageAppBarTitle),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // height:40,
                      child: Text(
                        "${_selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        AppString.selectDateTitle,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    CustomTextFormFiled(
                        controller: heightController,
                        text: "height",
                        icon: Icons.height,
                        isNumberonly: true),
                    // TextFormField(
                    //   // controller: ,
                    //   controller: heightController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(11),
                    //       ),
                    //       suffixText: "height",
                    //       prefixIcon: Icon(Icons.height)),
                    // ),
                    Container(
                      height: 15,
                    ),

                    CustomTextFormFiled(
                      controller: weightController,
                      text: "weight",
                      icon: Icons.line_weight,
                      isNumberonly: true,
                    ),
                    // TextFormField(
                    //   controller: weightController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(11),
                    //       ),
                    //       suffixText: "weight",
                    //       prefixIcon: Icon(Icons.line_weight)),
                    // ),
                    Container(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // await DatabaseHelper().initializeDatabase();

                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          SharedPreferences prefrnce =
                          await SharedPreferences.getInstance();
                          prefrnce.get("name");
                          await DatabaseHelper().insertRecord(
                              weight: int.parse(weightController.text),
                              height: int.parse(heightController.text),
                              date: _selectedDate.toLocal().toString(),
                              name: prefrnce.get("name").toString());
                          // await DatabaseHelper().getRecords();
                          getUserData();
                          print("^^^^^");
                        }

                      },
                      child: FittedBox(
                        child: Text(
                          AppString.submiteButton,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),

                    Text(isDataLoaded
                        ? userDataList.length.toString()
                        : AppString.loadingText)
                  ],
                ),
              ),
              isDataLoaded
                  ? Expanded(
                      // height: 00,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: userDataList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 300,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                                  .withOpacity(1.0),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userDataList[index]["date"].substring(0, 11),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      userDataList[index]["weight"].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _showAddDataDialog(context);
                                            updatedata(User(
                                              userDataList[index]['date']
                                                  .substring(0, 11),
                                              userDataList[index]['height']
                                                  .toString(),
                                              userDataList[index]['weight']
                                                  .toString(),
                                            ));
                                          });
                                        },
                                        child: Text(AppString.editButoonTitle)),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await DatabaseHelper().delete(
                                              userDataList[index]['date']
                                                  .toString());
                                          await getUserData();
                                          setState(() {});
                                        },
                                        child: Text(AppString.deleteButoonTitle))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
