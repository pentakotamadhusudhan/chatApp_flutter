import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samplevarun/user_profile_screen.dart';
import 'package:samplevarun/util/base_url.dart';

import 'findfriendsscreen.dart';
import 'getFriendscreen.dart';
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
    int loginId = args!.data!.id!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.white,
        leading: SizedBox(
          height: 30,
          width: 20,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserProfileScreen(
                  friendId: loginId,
                );
              }));
            },
            child: CircleAvatar(
              onBackgroundImageError: (x,y){
                print("Error loading image: $x, $y");
                 Image.asset('assets/images/chatbg.jpeg');
              },
              radius: 10, // Adjust to a value you find suitable
              backgroundColor: Colors.tealAccent,
              backgroundImage: args.data?.profileImage == null ? AssetImage('assets/images/logo.jpg') :
                  NetworkImage("${StaticUrl.baseUrl}${args.data!.profileImage}"),
            ),
          ),
        ),
        title: Text(args.data!.username!),
        titleTextStyle: TextStyle(fontSize: 16,color: Colors.black),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GetFriendsScreen(
                    loginId: loginId,
                  );
                }));
              },
              icon: const Icon(
                CupertinoIcons.bubble_left_bubble_right_fill,
                color: Colors.teal,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FindFriendListScreen(
                    loginId: loginId,
                  );
                }));
              },
              icon: Icon(
                Icons.people,
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
