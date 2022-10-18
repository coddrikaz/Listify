import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/FillDetails/login.dart';
import 'package:untitled1/SQFLite/DatabaseHelper.dart';
import 'package:untitled1/model/user.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController textName = TextEditingController();
  TextEditingController textMobile = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textUsername = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  final createUserFormKey = GlobalKey<FormState>();

  List<User> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: createUserFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    // Spacer(),
                    SizedBox(width: 6),
                    Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                TextFormField(
                  controller: textName,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.name,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Name!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.black, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: textMobile,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mobile Number!';
                    }
                    return null;
                  },

                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.black, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Mobile',
                    hintText: 'Enter Your Mobile Number',
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),

                  ),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: textEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email!';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  maxLength: 35,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.black, width: 0.0),
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Email',
                    hintText: 'Enter User Email',
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),

                  ),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: textUsername,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the username!';
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
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),

                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: textPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the strong password!';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  maxLength: 8,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.black, width: 0.0),
                    ),
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    hintStyle: const TextStyle(color: Colors.black26),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    errorText: validatePassword(textPassword.text),

                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 240,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal, // Background color
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward_sharp, size: 20,),
                            // const SizedBox(height: 50),
                          ],
                          ),
                        ),
                        onPressed: () async {
                          // ADD DB
                          if (createUserFormKey.currentState!.validate()) {
                            //
                            // try {
                            //   final result = await InternetAddress.lookup('example.com');
                            //   if (result.isNotEmpty &&
                            //       result[0].rawAddress.isNotEmpty) {
                                regeterApis();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Login()));
                              }
                          //   } on SocketException catch (_) {
                          //     _createAccToDb();
                          //     print('not connected');
                          //     var snackBar = const SnackBar(
                          //       content: Text(
                          //         'submitted User',
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //       backgroundColor: Colors.black,
                          //     );
                          //     // Step 3
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         snackBar);
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => Login()));
                          //   }
                          // }

                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Already have an account?',  style: TextStyle(
                      // fontSize: 20.0,
                      color: Colors.black45,
                    ),
                    ),

                    const SizedBox(height: 5),

                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                        // Fluttertoast.showToast(
                        //     msg: "Registered Successfully", backgroundColor: Colors.black12, textColor: Colors.black);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'Sign In',
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

  void _createAccToDb() {
    Map<String, dynamic> data = {
      "name": textName.text,
      "mobile": textMobile.text,
      "email": textEmail.text,
      "username": textUsername.text,
      "password": textPassword.text,
    };

    DatabaseHelper.internal().insertUser(data);
    DatabaseHelper.internal().queryAllRowsData().then((value) {
      setState(() {
        userList = value.cast<User>();
        print(value.length);
        textName.clear();
        textMobile.clear();
        textEmail.clear();
        textUsername.clear();
        textPassword.clear();
      });
    });
  }

  Future<String> regeterApis(
      {name, mobile, email, username, password, context}) async {
    // isloading:true;
    var apiURL = 'http://sonul.indevconsultancy.in/api/registration.php';

    Map<String, dynamic> getliks = {
      "name": textName.text,
      "mobile": textMobile.text,
      "email": textEmail.text,
      "username": textUsername.text,
      "password": textPassword.text,
    };
    //final prefs = await SharedPreferences.getInstance();

    Dio dio = Dio();
    Response responce;
    try {
      responce = await dio.post(
        apiURL,
        data: jsonEncode(getliks),
      );

      print("response data $responce");
      print("response data $getliks");

      if (responce.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Registered Successfully",  backgroundColor: Colors.black, textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: "Registered Failed",  backgroundColor: Colors.black, textColor: Colors.white);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "User Already exists",  backgroundColor: Colors.black, textColor: Colors.white);
      return 'some thing wrong';
    }
    return '';
  }

  String? validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

}
