import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samplevarun/chatscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:samplevarun/util/base_url.dart';

import 'model/getallfriendsmodel.dart';
// HomeScreen

class GetFriendsScreen extends StatefulWidget {
  int? loginId;
  GetFriendsScreen({this.loginId, super.key});

  @override
  State<GetFriendsScreen> createState() => _GetFriendsScreenState();
}

class _GetFriendsScreenState extends State<GetFriendsScreen> {
  List<Datum> friednsList = [];
  Future<void> getfirends() async {
    GetAllFriendsModel? getAllFriendsModel;
    getAllFriendsModel = await UserRepo().getFriendsListRepo();
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
          title: Text("Friends"),
          actions: [
            SizedBox(
              width: 20,
            )
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
                          builder: (context) => ChatScreen(
                            from_user: widget.loginId,
                            to_user: friednsList[index].id,
                            name: "${friednsList[index].username}",
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(friednsList[index].username!,maxLines: 1,),
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
                        backgroundImage: NetworkImage("StaticUrl.baseUrl +friednsList[index].profileImage!"),
                      ),
                      trailing: IconButton(
                          onPressed: () {},
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
