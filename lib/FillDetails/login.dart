import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/Api/Url.dart';
import 'package:untitled1/List/StudentList.dart';

import '../SQFLite/DatabaseHelper.dart';
import '../SharedPrefHelper.dart';
import '../model/user.dart';
import 'createAcount.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController textUsername = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();

  List<User> userList = [];
  bool _passwordVisible = false;
  String userID = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    // Spacer(),
                    SizedBox(width: 6),
                    // Icon(
                    //   Icons.arrow_right_alt_rounded,
                    //   color: Colors.black,
                    //   // size: 20,
                    // ),
                  ],
                ),
                const SizedBox(height: 30),
                Lottie.asset(
                  'assets/login.json',
                  height: 200,
                  width: 400,
                ),
                TextFormField(
                  controller: textUsername,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username has Required!';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  maxLength: 12,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.black, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Username',
                    hintText: 'Enter Username',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: !_passwordVisible,
                  controller: textPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password has Required!';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  maxLength: 14,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.0,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintStyle: const TextStyle(color: Colors.black26),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (loginFormKey.currentState!.validate()) {
                        final result =
                            await InternetAddress.lookup('example.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                           await loginApis();

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => MyHomePage(title: "Listify")));
                        }
                      }
                    } on SocketException catch (_) {
                      Fluttertoast.showToast(
                          msg: "Check The Internet Connection",
                          backgroundColor: Colors.black,
                          textColor: Colors.white);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: SizedBox(
                    width: 200,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Sign in',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_sharp,
                            size: 18, color: Colors.white),
                        // const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 140,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      """Don't have an account?""",
                      style: TextStyle(
                        // fontSize: 20.0,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateAccount()));
                        // Fluttertoast.showToast(
                        //     msg: "Registered Successfully", backgroundColor: Colors.black12, textColor: Colors.black);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                            // Spacer(),
                            SizedBox(width: 2),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> loginApis({username, password}) async {
    // isloading:true;
    SmartDialog.showLoading();
    var apiURL = 'http://sonul.indevconsultancy.in/api/login.php';

    Map<String, dynamic> getliks = {
      "username": textUsername.text,
      "password": textPassword.text,
    };
    //final prefs = await SharedPreferences.getInstance();

    Dio dio = Dio();
    Response responce;
    // try {
    responce = await dio.post(
      apiURL,
      data: jsonEncode(getliks),
    );

    print("response data $responce");

    print("response data $getliks");

    // if (responce.statusCode == 200) {
    print("hhhhhhh" + responce.data);
    final jsonData = json.decode(responce.data);

    SharedPrefHelper.setpref("namee", jsonData['name'].toString());
    SharedPrefHelper.setpref("emaill", jsonData['email'].toString());
    SharedPrefHelper.setpref("mobilee", jsonData['mobile'].toString());
    SharedPrefHelper.setpref("usernamee", jsonData['username'].toString());
    SharedPrefHelper.setpref("statuss", jsonData['status'].toString());
    print('hell ${jsonData['message']}');
    print('hell ${jsonData['email']}');
    print('hell ${jsonData['name']}');
    print('hellppp ${jsonData['mobile']}');
    print('hellppp ${jsonData['username']}');
    print("status msg $responce.statusMessage");



    print('loginnnnnnnnn ${jsonData['login_id']}');
    print('statussssssss ${jsonData['status']}');

    if (jsonData['status'] == 1) {
      SharedPrefHelper.setpref("login_id", jsonData['login_id']);
      await getData();
      Fluttertoast.showToast(
          msg: "Login Successfully",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      print("1111111111");
      SharedPrefHelper.setIsloginValue(true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage()));
      SmartDialog.dismiss();
    } else {
      SmartDialog.dismiss();
      Fluttertoast.showToast(
          msg: "Login Failed",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      print("000000000");
    }
    return '';
  }


  Future<void> getData() async {
    var userId = await SharedPrefHelper.getpref('login_id');
    print("GGGGGGGGGGG ${userId}");
    final dio = Dio();
    try {
      Response response = await dio.get("http://sonul.indevconsultancy.in/api/student_download.php?user_id=$userId");
      if (response.statusCode == 200) {
        var stateAPIResult = json.decode(response.data);
        await DatabaseHelper.internal().truncateTable("student");
        await DatabaseHelper.internal().saveMasterTable(stateAPIResult, "student");

        print(response.data);

      } else {
        print("Status Code Not 200");
      }
    } catch (e) {
      print("Api Call Error");
    }
  }
}
