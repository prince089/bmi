import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFiled extends StatelessWidget {
  TextEditingController controller;
  String text;
  IconData icon;
  bool isNumberonly;
   CustomTextFormFiled({super.key, required TextEditingController this.controller, required String this.text, required IconData this.icon,this.isNumberonly = false});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
        keyboardType: isNumberonly? TextInputType.number : null,
      validator: (value){
      if (value == null || value.isEmpty) {
        return 'this filed is requried';
      }
      return null;
      },
      inputFormatters: [
        isNumberonly ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.allow(RegExp(".+")),
      ],
      decoration: InputDecoration(

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          suffixText: text == 'height' ? "CM": text == "weight" ? "KG" : "",
          prefixIcon: Icon(icon),
          labelText: text
          // helperText: text
          // hintText: text,
      ),
    );
  }
}
