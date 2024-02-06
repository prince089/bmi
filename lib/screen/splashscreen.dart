import 'package:jeetbmi/asset/string.dart';
import 'package:jeetbmi/screen/homepage.dart';
import 'package:jeetbmi/screen/userdetail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isProfileSet = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>isProfileSet ? userhome():userpage()));
    });
  }
  Future getUserInfo()async {
    SharedPreferences preferce = await SharedPreferences.getInstance();
    isProfileSet = preferce.getBool(AppString.spisProfileSet) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/4uCk.gif"),
          ),
        ],
      ),
    );
  }
}

