import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samplevarun/chatscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/createuserscreen.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:samplevarun/homescreen.dart';

import 'friendslistscreen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: MyHomePage(title: 'Flutter Demo Home Page'),
            routes: {
              'chat': (context) => ChatScreen(name: "",),
              '/home': (context) => HomeScreen(),
              '/createUser': (context) => CreateUserScreen(),
            },
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.jpg"))),
              ),
            ),
        centerTitle: false,
        title: Text(
          "Madhu Sudhan",
          style: GoogleFonts.aclonicaTextTheme()
              .headlineLarge!
              .copyWith(color: Colors.indigo, fontSize: 38),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ResponsiveVisibility(
              visible: true,
              visibleConditions: [
                Condition.smallerThan(name: TABLET),
                Condition.smallerThan(name: DESKTOP),
              ],
              hiddenConditions: [
                Condition.equals(name: MOBILE),
                Condition.smallerThan(name: MOBILE),
              ],
              child: Container(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: NetworkImage(
                //             "assets/images/loginimage.jpg")
                              ),
                    // color: Colors.white),

              // ),
            ),
            // right
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Text(
                      "WELCOME BACK",
                      style: GoogleFonts.acmeTextTheme()
                          .labelLarge!
                          .copyWith(fontSize: 32),
                    ),
                  ),

                  30.verticalSpace,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          labelText: "User Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  20.verticalSpace,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                  30.verticalSpace,
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width*0.45,
                    child: ElevatedButton(
                      onPressed: () async {
                      UserLoginModel? userLogiModel =   await UserRepo().loginRepo(
                          userName: userNameController.text,
                          password: passwordController.text,
                        );
                      if(userLogiModel!.statusCode == 200){
                        Navigator.pushNamed(context, '/home',arguments: userLogiModel);

                      }
                      else {
                        showDialog(
                          context: context,
                           builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login Failed"),
                              content: Text("Invalid Credentials"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            );
                           },
                        );
                      }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Text(
                        "Login",
                        style: GoogleFonts.aBeeZeeTextTheme()
                            .headlineLarge!
                            .copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/createUser");
                    },
                    child: RichText(
                      text: const TextSpan(
                        text:
                            "Don't Have An Account ? ", // First part of the text
                        style: TextStyle(
                            color: Colors.black), // Default text style
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Click Here', // Second part of the text
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  const Text(
                    "Or Continue with",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  10.verticalSpace,
                  const SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(
                        //     height: 30,
                        //     width: 30,
                        //     child: Image(
                        //         image:
                        //             NetworkImage("assets/images/google.png"))),
                        // SizedBox(
                        //     height: 30,
                        //     width: 30,
                        //     child: Image(
                        //         image:
                        //             NetworkImage("assets/images/facebook.png")))
                      ],
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
