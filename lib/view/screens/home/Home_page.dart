import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image(
                  image: AssetImage(
                    "assets/images/drsanjeevika_logo.png",
                  ),
                  width: size / 2.3,
                ),
                SizedBox(
                  width: size / 15,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      size / 120, size / 180, size / 12, size / 180),
                  decoration: BoxDecoration(
                    color: Color(0xffB2E4FF), // light blue background
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(50), // capsule shape
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: size / 25,
                        child: Icon(
                          Icons.person,
                          size: size / 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(width: size / 35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. John',
                            style: TextStyle(
                              color: Color(0xff005AC4), // dark green text
                              fontWeight: FontWeight.bold,
                              fontSize: size / 25,
                            ),
                          ),
                          SizedBox(height: size / 150),
                          Text(
                            'Cardiologist',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xffA1D8FF),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffA1D8FF), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.center)),
          ),
        ));
  }
}
