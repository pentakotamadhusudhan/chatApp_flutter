import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samplevarun/chatscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/repo/userrepo.dart';

import 'model/getallfriendsmodel.dart';
// HomeScreen

class FriendsListScreen extends StatefulWidget {
  int? loginId;
  FriendsListScreen({this.loginId, super.key});

  @override
  State<FriendsListScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FriendsListScreen> {
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
          :  SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: friednsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print(
                            "-------------- friend id ${friednsList[index].id}");
                        // Navigator.pushNamed(context, 'chat',
                        //     arguments: {
                        //       "from_user": loginId,
                        //       "to_user": friednsList[index].id
                        //     });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  from_user: widget.loginId,
                                  to_user: friednsList[index].id,
                                  name: "${friednsList[index].username}",
                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${friednsList[index].username}"),
                            Text("${friednsList[index].email}"),
                            Text("${friednsList[index].id}"),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      )
    );
  }
}
