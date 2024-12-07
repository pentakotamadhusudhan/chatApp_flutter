import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'friendslistscreen.dart';
import 'model/userloginmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as UserLoginModel?;
    int loginId = args!.data.id;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SizedBox(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return FriendsListScreen(loginId:loginId ,);
                }));
              },
              icon: Icon(
                Icons.people,
                color: Colors.teal,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bubble_left_bubble_right_fill,
                color: Colors.teal,
              ))
        ],
      ),
      body: Center(
        child: Text("Home screen"),
      ),
    );
  }
}



