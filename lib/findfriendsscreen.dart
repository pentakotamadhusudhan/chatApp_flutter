import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samplevarun/chatscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:samplevarun/util/base_url.dart';

import 'frienddetailsscreen.dart';
import 'model/getallfriendsmodel.dart';
// HomeScreen

class FindFriendListScreen extends StatefulWidget {
  int? loginId;
  FindFriendListScreen({this.loginId, super.key});

  @override
  State<FindFriendListScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FindFriendListScreen> {
  List<Datum> friednsList = [];
  Future<void> getfirends() async {
    GetAllFriendsModel? getAllFriendsModel;
    getAllFriendsModel = await UserRepo().getFindFriendsListRepo();
    print("user model data $getAllFriendsModel");

    friednsList = getAllFriendsModel!.data!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getfirends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments as UserLoginModel?;
    // int loginId = args!.data.id;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Find friends"),
          actions: [
            IconButton(
                onPressed: () {
                  UserRepo().getFriendByIDRepo(friendID: 1);
                },
                icon: Icon(Icons.search))
          ],
        ),
        backgroundColor: Colors.white,
        body: widget.loginId == null
            ? Text("No data found")
            : SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.8, // 80% of the screen height
                child: ListView.builder(
                  itemCount: friednsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.blue,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            print(
                                "-------------- friend id ${friednsList[index].id}");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FriendDetailScreen(friendId:friednsList[index].id! ,)));
                          },
                          child: ListTile(
                            title: Text(
                              friednsList[index].username!,
                              maxLines: 1,
                            ),
                            titleTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            subtitle: Text(
                              friednsList[index].bio!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitleTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45),
                            leading: CircleAvatar(
                              onBackgroundImageError: (x, y) {},
                              backgroundImage: NetworkImage(
                                  "${StaticUrl.baseUrl}${friednsList[index].profileImage}"),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        from_user: widget.loginId,
                                        to_user: friednsList[index].id,
                                        name: "${friednsList[index].username}",
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.message_outlined,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
