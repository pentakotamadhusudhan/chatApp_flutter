import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samplevarun/createuserscreen.dart';
import 'package:samplevarun/model/userloginmodel.dart';
import 'package:samplevarun/repo/userrepo.dart';
import 'package:samplevarun/util/base_url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'model/getallfriendsmodel.dart';
import 'model/messagesModel.dart';

class ChatScreen extends StatefulWidget {
  final int? from_user;
  final int? to_user;
  final String name;

  ChatScreen({
    this.from_user,
    this.to_user,
    required this.name,
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
  Datum? friendDetails;
  List chatMessages = [];

  Future<Datum?> getfriendDetails() async {
    print("user model data ");
    friendDetails =
        await UserRepo().getFriendByIDRepo(friendID: widget.to_user!);
    print("user model data $friendDetails");
    return friendDetails;
  }

  @override
  void initState() {
    super.initState();

    _messageController = TextEditingController();

    // Initialize WebSocket channels
    _counterChannel = WebSocketChannel.connect(
        Uri.parse('${StaticUrl.webSocketUrl}counter/'));
    _timerChannel =
        WebSocketChannel.connect(Uri.parse('${StaticUrl.webSocketUrl}timer/'));
    // Send initial messages to the WebSocket servers
    _counterChannel.sink.add(jsonEncode({"action": "minus"}));
    _timerChannel.sink.add(jsonEncode({"action": "increment"}));
    // Repeatedly send messages every 1 second (adjust interval as needed)
    _counterTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _counterChannel.sink.add(jsonEncode({"action": "minus"}));
    });
    _timerTimer = Timer.periodic(const Duration(seconds: 1), (_) {
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
    fromUser = widget.from_user!;
    toUser = widget.to_user!;
    _chatChannel = WebSocketChannel.connect(
        Uri.parse('${StaticUrl.webSocketUrl}chat/$fromUser/$toUser/'));
    print("url ${'${StaticUrl.webSocketUrl}chat/$fromUser/$toUser/'}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.name),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: getfriendDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/chatbg.jpeg",
                        ),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 10, // Adjusted for space between UI elements
                      bottom: 60, // Make room for the TextField at the bottom
                      child: StreamBuilder(
                        stream: _chatChannel.stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: Text('Waiting for messages...'));
                          }
                          final data = jsonDecode(snapshot.data!);
                          // Check if the response contains chat data
                          if (data['status'] == 200 && data['data'] != null) {
                            chatMessages = data['data'];
                            return ListView.builder(
                              key: anchor,
                              controller: myController,
                              itemCount: chatMessages.length,
                              itemBuilder: (context, index) {
                                final message = chatMessages[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        fromUser == message['from_user']
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      10.horizontalSpace,
                                      Container(
                                        // width: MediaQuery.of(context).size.width * 0.8,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(message['message']),
                                            const SizedBox(height: 5),
                                            Text(
                                                "From: ${message['from_user']} To: ${message['to_user']}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
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
                          return const Center(
                              child: Text('Unknown data received.'));
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
                                  contentPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  hintText: 'Enter your message...',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                MessageModel? messageModel =
                                    await UserRepo().sendMessageRepo(
                                  message: _messageController.text,
                                  from_user: fromUser.toString(),
                                  to_user: toUser.toString(),
                                );
                                chatMessages.add(messageModel!.data!);
                              },
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Failed to connect to server.'));
            }
          }),
    );
  }
}
