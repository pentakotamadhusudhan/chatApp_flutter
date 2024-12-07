import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplevarun/friendslistscreen.dart';

import 'util/custom_buttons.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen>
with SingleTickerProviderStateMixin
{
 late TabController _tabController ;
 @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/signupimage.jpg")),
                color: Colors.white),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/logo.jpg"))),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 50,
                  child: Container(
                    height: 50,
                    child: Text(
                      "Madhu Sudhan",
                      style: GoogleFonts.aclonicaTextTheme()
                          .headlineLarge!
                          .copyWith(color: Colors.indigo, fontSize: 38),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // form
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width / 2,

            alignment: Alignment.center,
            child: TabBarView(
                controller: _tabController,
                children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        // controller: userNameController,
                        decoration: InputDecoration(
                            labelText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        // controller: userNameController,
                        decoration: InputDecoration(
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        // controller: userNameController,
                        decoration: InputDecoration(
                            labelText: "User Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        // controller: userNameController,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  submitButton(
                    label: "Next",
                    onpressed: () {
                      _tabController.animateTo(1);
                    },
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        // controller: userNameController,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        // controller: userNameController,
                        decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  submitButton(
                    label: "Sign up",
                    onpressed: () {
                      _tabController.animateTo(0);
                    },
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
