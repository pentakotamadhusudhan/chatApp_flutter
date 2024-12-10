
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:samplevarun/repo/userrepo.dart';

import 'util/custom_buttons.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _tabController.dispose();
    super.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          ResponsiveVisibility(
            visible: false,
            visibleConditions: [],
            child: Container(
              // width: MediaQuery.of(context).size.width / 2,
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
          ),
          30.verticalSpace,
          // form
          Container(
            width: MediaQuery.of(context).size.width,
            // color: Colors.blue,
            alignment: Alignment.center,
            child: TabBarView(controller: _tabController, children: [
              Column(
                children: [
                  customeTextFieldWidget(
                      context: context,
                      text: "First Name",
                      controller: firstNameController),
                  customeTextFieldWidget(
                      context: context,
                      text: "Last Name",
                      controller: lastNameController),
                  customeTextFieldWidget(
                      context: context,
                      text: "User Name",
                      controller: userNameController),
                  customeTextFieldWidget(
                      context: context,
                      text: "Email ",
                      controller: emailController),
                  20.verticalSpace,
                  submitButton(
                    label: "Next",
                    onpressed: () {
                      _tabController.animateTo(1);
                    },
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                ],
              ),
              Column(
                children: [
                  customeTextFieldWidget(
                      context: context,
                      text: "Password",
                      controller: passwordController),
                  customeTextFieldWidget(
                      context: context,
                      text: "Co-Password",
                      controller: confirmPasswordController),
                  20.verticalSpace,
                  submitButton(
                    label: "Sign up",
                    onpressed: () {
                      // _tabController.animateTo(0);
                      UserRepo().userCreateRepo(
                        context: context,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        userName: userNameController.text,
                        email: emailController.text,
                        // phoneNumber: phoneNumberController.text,
                        password: passwordController.text,
                        // confirmPassword: confirmPasswordController.text,
                      );
                    },
                    width: MediaQuery.of(context).size.width * 0.45,
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

Padding customeTextFieldWidget(
    {required BuildContext context,
    required String text,
    required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: text,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
      ),
    ),
  );
}
