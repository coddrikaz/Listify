import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'FillDetails/login.dart';
import 'List/StudentList.dart';
import 'SharedPrefHelper.dart';

class Splace extends StatefulWidget {
  const Splace({Key? key}) : super(key: key);

  @override
  State<Splace> createState() => _SplaceState();
}

class _SplaceState extends State<Splace> {
  @override
  void initState() {
    super.initState();
    startTimer();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // child:FlutterLogo(size:MediaQuery.of(context).size.height)
      child: Lottie.asset(
        'assets/spalce.json',
        height: 200,
        width: 200,
      ),
    );
  }


  startTimer() async {
    bool isLoggedIn = await SharedPrefHelper.getIsLoginValue();
    await Future.delayed(const Duration(seconds: 2));
    if (isLoggedIn) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
        }
  }

}
