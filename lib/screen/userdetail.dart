import 'package:jeetbmi/asset/string.dart';
import 'package:jeetbmi/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:jeetbmi/widget/customTextFormFiled.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userpage extends StatefulWidget {
  const userpage({super.key});

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.orange,
        ),
        body: Center(
            child: Container(
                width: 300,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormFiled(controller:name,text:"Name",icon:Icons.person),
                        // TextFormField(
                        //   controller: name,
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(11),
                        //       ),
                        //       suffixText: "Name",
                        //       prefixIcon: Icon(Icons.person)),
                        // ),
                        Container(
                          height: 15,
                        ),
                        CustomTextFormFiled(controller:gender,text:"Gender",icon:Icons.male),
                        // TextFormField(
                        //   controller: gender,
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(11),
                        //       ),
                        //       suffixText: "Gender",
                        //       prefixIcon: Icon(Icons.male),
                        //       hintText: "Gender",
                        //   ),
                        // ),
                        Container(
                          height: 15,
                        ),

                        CustomTextFormFiled(controller:height,text:"Height",icon:Icons.height,isNumberonly: true,),
                        // TextFormField(
                        //   controller: height,
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(11),
                        //       ),
                        //       suffixText: "Height",
                        //       prefixIcon: Icon(Icons.height)),
                        // ),
                        Container(
                          height: 15,
                        ),
                        CustomTextFormFiled(controller:weight,text:"Weight",icon:Icons.monitor_weight_outlined,isNumberonly: true),
                        // TextFormField(
                        //   controller: weight,
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(11),
                        //       ),
                        //       suffixText: "Weight",
                        //       prefixIcon: Icon(Icons.monitor_weight_outlined)),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.grey),
                          ),
                          child:  Text(AppString.submiteButton),
                          onPressed: () async{

                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              await addUser(name:name.text,gender:gender.text,height:height.text,weight:weight.text);
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>const userhome())
                              );
                            }

                          },
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  Future addUser({required String name, required String gender, required String weight, required String height}) async{
    SharedPreferences prefrence = await SharedPreferences.getInstance();
    prefrence.setString(AppString.spName, name);
    prefrence.setString(AppString.spHeight, height);
    prefrence.setString(AppString.spWeight, weight);
    prefrence.setBool(AppString.spisProfileSet, true);
    // prefrence.setString("gender", gender);

  }
}
