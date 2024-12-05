import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samplevarun/createuserscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final int? from_user;
  final int? to_user;

  ChatScreen({
    this.from_user,
    this.to_user,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel _counterChannel;
  late WebSocketChannel _timerChannel;
  late WebSocketChannel _chatChannel;
  late Timer _counterTimer;
  late Timer _timerTimer;
  late TextEditingController _messageController;
  late int fromUser = 0;
  late int toUser = 0;
  int counter = 0;
  int timer = 0;
  ScrollController myController = ScrollController();
  final anchor = GlobalKey();
 Data? friendDetails;
  Future<void> getfriendDetails()async{
    friendDetails =await  UserRepo().getFriendByIDRepo(friendID: widget.to_user!);
    print("user model data $friendDetails");
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();
    getfriendDetails();
    _messageController = TextEditingController();

    // Initialize WebSocket channels
    _counterChannel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.2.82:8000/ws/counter/'));
    _timerChannel =
        WebSocketChannel.connect(Uri.parse('ws://192.168.2.82:8000/ws/timer/'));

    // Send initial messages to the WebSocket servers
    _counterChannel.sink.add(jsonEncode({"action": "minus"}));
    _timerChannel.sink.add(jsonEncode({"action": "increment"}));

    // Repeatedly send messages every 1 second (adjust interval as needed)
    _counterTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _counterChannel.sink.add(jsonEncode({"action": "minus"}));
    });
    _timerTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _timerChannel.sink.add(jsonEncode({"action": "increment"}));
    });
  }

  @override
  void dispose() {
    // Close WebSocket channels and cancel timers when widget is disposed
    _counterChannel.sink.close();
    _timerChannel.sink.close();
    _chatChannel.sink.close();
    _counterTimer.cancel();
    _timerTimer.cancel();
    super.dispose();
  }

  void sendMessage(String message) {
    UserRepo().sendMessageRepo(
      message: _messageController.text,
      from_user: fromUser.toString(),
      to_user: toUser.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print("fromuser2${args['from_user']}");
    print("touser2${args['to_user']}");
    fromUser = args['from_user'] as int;
    toUser = args['to_user'] as int;
    _chatChannel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.2.82:8000/ws/chat/${fromUser}/${toUser}/'));
    print("url ${'ws://192.168.2.82:8000/ws/chat/${fromUser}/${toUser}/'}");
    return Scaffold(
      appBar: AppBar(
        title: Text("${friendDetails!.firstName} ${friendDetails!.lastName}"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // SafeArea widget for RealTimeCounterPage (or any other widget you want at the top)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Real-time Counter Stream
                    StreamBuilder(
                      stream: _counterChannel.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Waiting for data...'));
                        }
                        final data = jsonDecode(snapshot.data!);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.adb_rounded, color: Colors.green),
                            Text("Online: ${data['counter']}"),
                          ],
                        );
                      },
                    ),

                    // Real-time Timer Stream
                    StreamBuilder(
                      stream: _timerChannel.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Waiting for timer...'));
                        }
                        final data = jsonDecode(snapshot.data!);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.timer, color: Colors.blue),
                            Text("Timer: ${data['counter']}"),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Positioned ListView to display chat messages
            Positioned(
              left: 0,
              right: 0,
              top: 120, // Adjusted for space between UI elements
              bottom: 60, // Make room for the TextField at the bottom
              child: StreamBuilder(
                stream: _chatChannel.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Waiting for messages...'));
                  }

                  final data = jsonDecode(snapshot.data!);

                  // Check if the response contains chat data
                  if (data['status'] == 200 && data['data'] != null) {
                    List chatMessages = data['data'];
                    return ListView.builder(
                      key: anchor,
                      controller: myController,
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = chatMessages[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: fromUser == message['from_user']
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Container(
                              //     height: 30,
                              //     width: 30,
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       image: DecorationImage(
                              //         image: AssetImage(
                              //             fromUser == message['from_user']
                              //                 ? "assets/images/logo.jpg"
                              //                 : "assets/images/google.png"),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              10.horizontalSpace,
                              Container(
                                // width: MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(message['message']),
                                    SizedBox(height: 5),
                                    Text(
                                        "From: ${message['from_user']} To: ${message['to_user']}",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              10.horizontalSpace
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return Center(child: Text('Unknown data received.'));
                },
              ),
            ),

            // Positioned TextField at the bottom for sending messages
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.92,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: 'Enter your message...',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        UserRepo().sendMessageRepo(
                          message: _messageController.text,
                          from_user: fromUser.toString(),
                          to_user: toUser.toString(),
                        );
                        _messageController.clear();
                        myController
                            .jumpTo(MediaQuery.of(context).size.height + 10);
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
