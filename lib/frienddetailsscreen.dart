import 'package:flutter/material.dart';
import 'package:samplevarun/repo/userrepo.dart';

import 'model/getallfriendsmodel.dart';

class FriendDetailScreen extends StatefulWidget {
  int friendId;
   FriendDetailScreen({
     required this.friendId,
     super.key});

  @override
  State<FriendDetailScreen> createState() => _FriendDetailScreenState();
}

class _FriendDetailScreenState extends State<FriendDetailScreen> {
  Datum? friendData;
  Future<void> getFriendDetails()async{
  friendData =  await UserRepo().getFriendByIDRepo(
        friendID: widget.friendId);
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
      appBar: AppBar(
        title: Text('Friend Details'),
      ),
      body:friendData==null? CircularProgressIndicator(): Center(
        child: Column(
          children: [
            Text('Friend Name: ${friendData!.firstName} ${friendData!.lastName}'),
            Text('Age: 30'),
            Text('Email: ${friendData!.email}'),
            Text('Phone: ${friendData!.bio}'),
          ],
        ),
      ),
    );
  }
}
