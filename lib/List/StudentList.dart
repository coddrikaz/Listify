import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/SQFLite/DatabaseHelper.dart';
import 'package:untitled1/SharedPrefHelper.dart';
import 'package:untitled1/View/StudentDetails.dart';
import 'package:untitled1/model/user.dart';

import '../FillDetails/form.dart';
import '../FillDetails/login.dart';
import '../model/Student.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool isFAB = true;

  // String? userID;
  String namee = "";
  String emaill = "";
  String mobilee = "";
  String usernamee = "";
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<Student>? taskList = [];
  late String userCurrency;
  late User userData;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    databaseHelper.queryAllRows().then((value) {
      // taskList?.clear();
      taskList = value.cast<Student>();
      setState(() {});
      getshared();
    });
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        setState(() {
          isFAB = false;
        });
      } else {
        setState(() {
          isFAB = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listify"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add_card_rounded,
            ),
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Don't Click",
                  backgroundColor: Colors.black,
                  textColor: Colors.white);
            },
            padding: const EdgeInsets.symmetric(horizontal: 15),
          )
        ],
      ),

      //DRAWER
      // drawer: buildDrawer(context),

      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF00695C)),
                accountName: Text(namee),
                accountEmail: Text(emaill),
                arrowColor: Colors.white,
                onDetailsPressed: showToast,
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/zakir.jpeg'),
                  backgroundColor: Color.fromARGB(255, 155, 203, 100),
                ),
                //circleAvatar
              ), //UserAccountDrawerHeader
            ),
            Visibility(
              visible: _isVisible,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00695C).withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        // margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Name : ${namee}"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),

                        child: Text("Email : ${emaill}"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),

                        child: Text("Mobile : ${mobilee}"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),

                        child: Text("Username : ${usernamee}"),
                      ),
                    ],
                  ),
                ),
              ),
            ), //DrawerHeader
            // _isVisible == false
            //     ?
            Container(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(' My Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text(' My Course '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.workspace_premium),
                    title: const Text(' Go Premium '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.video_label),
                    title: const Text(' Saved Videos '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text(' Edit Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('LogOut'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure want to logout?'),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    child: Lottie.asset(
                                      'assets/cancel.json',
                                      height: 50,
                                      width: 100,
                                      repeat: false,
                                      reverse: true,
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    child: Container(
                                      child: Lottie.asset(
                                        'assets/ok.json',
                                        height: 50,
                                        width: 100,
                                        repeat: true,
                                        reverse: true,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // : Container(),
          ],
        ),
      ),
      //BODY
      body: Container(
        padding: const EdgeInsets.all(3),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                child: taskList!.isEmpty
                    ? Container()
                    : ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: taskList!.length,
                        itemBuilder: (ctx, index) {
                          if (index == taskList!.length) {
                            return const CircularProgressIndicator();
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StudentDetails(
                                        student: taskList![index],
                                      )));
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Container(
                                    padding: const EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 10,
                                          blurRadius: 2,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          taskList![index].name,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          taskList![index].email,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          taskList![index].gender,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          taskList![index].contact,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          taskList![index].occuption,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: const Text("Okay",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.teal,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text("Name",
                                            style: TextStyle(fontSize: 16)),
                                        Text("Email",
                                            style: TextStyle(fontSize: 16)),
                                        Text("Contact",
                                            style: TextStyle(fontSize: 16)),
                                        Text("Occupation",
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ':  ${taskList![index].name}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          ':  ${taskList![index].email}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          ':  ${taskList![index].contact}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          ':  ${taskList![index].occuption}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        // SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // width: 50.0,
                                    // height: 50.0,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        // color: Colors.teal,
                                        ),
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.black),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text(
                                                'Are you sure want to Delete?'),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child:
                                                          const Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        _deleteTask(
                                                            taskList![index]
                                                                .id);
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: const Text('Ok')),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyAppScreen()));
        },
        isExtended: isFAB,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        label: const Text('Compose'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  //DELETE TASK
  void _deleteTask(int id) async {
    await DatabaseHelper.internal().delete(id);
    setState(() {
      taskList!.removeWhere((element) => element.id == id);
    });
  }

  Future<void> setData() async {
    final dio = Dio();
    try {
      Response response = await dio
          .get("http://sonul.indevconsultancy.in/api/student_download.php");
      if (response.statusCode == 200) {
        var stateAPIResult = json.decode(response.data);
        DatabaseHelper.internal().truncateTable("student");
        DatabaseHelper.internal().saveMasterTable(stateAPIResult, "student");

        print(response.data);
      } else {
        print("Status Code Not 200");
      }
    } catch (e) {
      print("Api Call Error");
    }
  }

  getData() async {
    String userid = await SharedPrefHelper.getpref("login_id");
    DatabaseHelper.internal().queryAllRows().then((value) => {
          taskList = value,
          setState(() {}),
          print(value.length),
        });
  }

  getshared() async {
    namee = await SharedPrefHelper.getpref('namee');
    emaill = await SharedPrefHelper.getpref('emaill');
    mobilee = await SharedPrefHelper.getpref('mobilee');
    usernamee = await SharedPrefHelper.getpref('usernamee');
  }
}
