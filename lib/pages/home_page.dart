import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_page/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          width: size.width,
          height: size.height,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: size.width,
                  height: size.height / 8,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: size.width / 30,
                        ),
                        const Text(
                          'My Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(ProfilePage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
