import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samplevarun/chatscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/repo/userrepo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> friednsList = [] ;

  Future<void> getfirends()async{
    friednsList =await  UserRepo().getFriendsListRepo();
    print("user model data $friednsList");
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getfirends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)?.settings.arguments as UserLoginModel?;
    int loginId= args!.data.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                  context,

                  'chat');
            },
            icon: Icon(
              CupertinoIcons.bubble_left_bubble_right_fill,
              color: Colors.lightBlueAccent,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body:args == null ? Text("No data found"): Column(
        children: [
          Text(
            'Person 1',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(


            child: Expanded(child: ListView.builder(
              shrinkWrap: true,
                itemCount: friednsList.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, 'chat',arguments: {"from_user":loginId,"to_user":friednsList[index].id});
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(from_user: 1,to_user: userLoginModel[index].id,)));
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

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
        ],
      ),
    );
  }
}
