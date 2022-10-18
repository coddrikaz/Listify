

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../FillDetails/login.dart';


Widget buildDrawer(BuildContext context) => Drawer(

  child: ListView(
    padding: const EdgeInsets.all(0),
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.teal,
        ), //BoxDecoration
        child: UserAccountsDrawerHeader(
          // margin: EdgeInsets.all(15),
          decoration: BoxDecoration(color: Color(0xFF00695C)),
          accountName: Text("zakir Husain"),
          accountEmail: Text("zakirhusain.zrh@gmail.com"),
          currentAccountPictureSize: Size.square(50),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/zakir.jpeg'),
            backgroundColor: Color.fromARGB(255, 155, 203, 100),
          ),
          //circleAvatar
        ), //UserAccountDrawerHeader
      ), //DrawerHeader
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
                          Navigator.of(context).push(MaterialPageRoute(
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
    );
