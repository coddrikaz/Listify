import 'package:flutter/material.dart';
import 'package:untitled1/model/Student.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  late Student st;

  @override
  void initState() {
    super.initState();
    st = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.teal,
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    const Text("Name",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 70),
                    Text(": ${st.name}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text("Email",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 76),
                      Text(": ${st.email}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                child: Row(
                  children: [
                    const Text("Contact",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 55),
                    Text(": ${st.contact}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                child: Row(
                  children: [
                    const Text("Gender",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 57),
                    Text(": ${st.gender}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        child: const Text("Occupation",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 18),
                      Container(
                        child: Text(": ${st.occuption}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Container(
              //   width: 100,
              //   height: 40,
              //   // margin: EdgeInsets.all(10),
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   alignment: Alignment.centerLeft,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(
              //       color: Colors.black,
              //     ),
              //     borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              //     // borderRadius: BorderRadius.all(
              //     //   Radius.circular(10),
              //     // ),
              //   ),
              //   child: const Text("Name",
              //       style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold)),
              // ),

              // Container(
              //   height: 40,
              //   // margin: EdgeInsets.all(10),
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   alignment: Alignment.centerLeft,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border.all(
              //       color: Colors.black,
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.2),
              //         spreadRadius: 5,
              //         blurRadius: 7,
              //         offset: const Offset(0, 3), // changes position of shadow
              //       ),
              //     ],
              //     // borderRadius: BorderRadius.all(
              //     //   Radius.circular(10),
              //     // ),
              //   ),
              //  child: Text(": ${st.name}",
              //       style: const TextStyle(
              //           fontSize: 20,
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold)),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
