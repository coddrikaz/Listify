
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/SQFLite/DatabaseHelper.dart';
import 'package:untitled1/SharedPrefHelper.dart';
import 'package:untitled1/model/Student.dart';

import '../List/StudentList.dart';

class MyAppScreen extends StatefulWidget {


  @override
  _MyAppScreenState createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyAppScreen> {

  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textContact = TextEditingController();
  TextEditingController textOccupation = TextEditingController();
  List<Student> taskList = [];
  String? gender;
  bool a = true;

  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(

        title: const Text('Details'),
      ),

        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(30.0),
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //
          //         colors: [Color(0xFFE0F2F1), Colors.white]),
          // ),
          child: SingleChildScrollView(
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: textName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Name';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    maxLength: 15,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            BorderSide(color: Colors.teal, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                      hintStyle: TextStyle(color: Colors.black26),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      // errorText: validatePassword(textName.text),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: textEmail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Email';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 35,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            BorderSide(color: Colors.teal, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Email',
                      hintText: 'Enter Your Email',
                      hintStyle: TextStyle(color: Colors.black26),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    cursorColor:Colors.white,
                    controller: textContact,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Mobile Number';
                      }
                      return null;
                    },
                    maxLength: 10,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            BorderSide(color: Colors.teal, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Contact',
                      hintText: 'Enter User Number',
                      hintStyle: TextStyle(color: Colors.black26),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: _visibilitymethod,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.teal,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Gender", style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          if (a == false)
                            const Icon(Icons.arrow_drop_up)
                          else
                            const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  a == false
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.teal,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RadioListTile(
                                title: const Text("Male"),
                                value: "male",
                                groupValue: gender,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                title: const Text("Female"),
                                value: "female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("Other"),
                                value: "other",
                                groupValue: gender,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              )
                            ],
                          ),
                        )
                      : Container(),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: textOccupation,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Occupation';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                    maxLength: 15,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            BorderSide(color: Colors.teal, width: 1.0),
                      ),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Occupation',
                      hintText: 'Enter Your Occupation',
                      hintStyle: TextStyle(color: Colors.black26),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),

                  const SizedBox(height: 50),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),

                      shadowColor: Colors.black, // Background color
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 18,
                            color: Colors.white,
                          ),
                          // const SizedBox(height: 50),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      // try {
                        if (loginFormKey.currentState!.validate()) {
                      //     // if (loginFormKey.currentState!.validate()) {
                      //       final result =
                      //           await InternetAddress.lookup('example.com');
                      //       if (result.isNotEmpty &&
                      //           result[0].rawAddress.isNotEmpty) {
                              studentApi();
                              _addToDb();
                      //         print("jjjjjjjjjjjjjjjjjjjjjjjjjj");
                      //       }
                          }
                      //   }
                      // } on SocketException catch (_) {
                      //   print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                      //   // if (loginFormKey.currentState!.validate()) {
                      //     _addToDb();
                      //     Fluttertoast.showToast(
                      //         msg: "Saved Successfully",
                      //         backgroundColor: Colors.black);
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => MyHomePage(
                      //               title: 'Listify',
                      //             )));
                      //   // }
                      // }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),

    );
  }

  Future<void> _addToDb() async {
    String userId = await SharedPrefHelper.getpref("login_id");

    Map<String, dynamic> data = {
      "name": textName.text,
      "email": textEmail.text,
      "contact": textContact.text,
      "occuption": textOccupation.text,
      "gender": gender,
      "user_id": userId,
    };

    DatabaseHelper.internal().insert(data);
    DatabaseHelper.internal().queryAllRows().then((value) {
      setState(() {
        taskList = value;
        print(value.length);
        textName.clear();
        textEmail.clear();
        textContact.clear();
        textOccupation.clear();
      });
    });
  }

  studentApi() async {
    Response res = await Dio()
        .post("http://sonul.indevconsultancy.in/api/student-add.php", data: {
      "name": textName.text,
      "email": textEmail.text,
      "contact": textContact.text,
      "occuption": textOccupation.text,
      "gender": gender,
      "user_id": await SharedPrefHelper.getpref("login_id"),
    });
    debugPrint(res.data);
    final jsonData = json.decode(res.data);
    debugPrint(jsonData.toString());
    if (jsonData['status'] == 1) {
      Fluttertoast.showToast(msg: "successfully added!");
      print('LLLLLLLLLLLLL ${jsonData['status']}');
      print('OOOOOOOOOO $jsonData');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MyHomePage()));
    } else {
      Fluttertoast.showToast(msg: res.data.toString());
    }
  }

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        Icons.arrow_drop_up;
      } else {
        a = true;
        Icons.arrow_drop_down;
      }
    });
  }
}
