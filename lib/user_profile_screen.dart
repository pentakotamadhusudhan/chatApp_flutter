import 'package:flutter/material.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:samplevarun/util/custome_text_styles.dart';

import 'model/getallfriendsmodel.dart';

class UserProfileScreen extends StatefulWidget {
  int friendId;
  UserProfileScreen({required this.friendId, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Datum? friendData;
  Future<void> getFriendDetails() async {
    friendData = await UserRepo().getFriendByIDRepo(friendID: widget.friendId);
    setState(() {
      friendData;
    });
  }

  @override
  void initState() {
    getFriendDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: friendData == null
          ? CircularProgressIndicator()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 320,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: AssetImage("assets/images/chatbg.jpeg"))
                  ),

                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,

                        ),
                        padding: EdgeInsets.all(8),
                        child: Image(image: friendData!.profileImage == null
                            ? AssetImage('assets/images/google.png')
                            : NetworkImage(friendData!.profileImage!),
                          fit: BoxFit.cover,),
                      ),
                      Text(
                          '${friendData!.firstName} ${friendData!.lastName}',style: ConstTextStyles.firstNameTextStyle,),
                      Text('@${friendData!.username}',style: ConstTextStyles.userNameTextStyle,),
                      // Text('${friendData!.email}',style: ConstTextStyles.userName,),
                    ],
                  ),
                ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('About Me', style: ConstTextStyles.firstNameTextStyle.copyWith(color: Colors.blue),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),

                  child: Text('${friendData!.bio}',style: ConstTextStyles.bioTextStyle.copyWith(color: Colors.black),)),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date of Birth', style: ConstTextStyles.firstNameTextStyle.copyWith(color: Colors.blue),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit,size: 20,))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),

                  child: Text('${friendData!.dob ??"NA"}',style: ConstTextStyles.bioTextStyle.copyWith(color: Colors.black),)),

            ],
          ),
    );
  }
}
