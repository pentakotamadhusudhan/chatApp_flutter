import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Icon(CupertinoIcons.bubble_left_bubble_right_fill,color: Colors.lightBlueAccent,),
         SizedBox(width: 20,)
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text('Person 1',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500),),
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/logo.jpg"))),
              ),
              Container(
                height: 40,

                decoration:  BoxDecoration(
color: Colors.lightBlue.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50),
                    ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(5),
                child: Text("madhu is good is boy"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
