import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    print("width scroll ${MediaQuery.of(context).size.width}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // SafeArea widget for RealTimeCounterPage (or any other widget you want at the top)
            SafeArea(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RealTimeCounterPage(),
            )),

            // Positioned ListView on the right side with scrollable behavior
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 60, // Make room for the TextField at the bottom
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 30, // Use the length of your data list
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5, // Half the width
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 30,
                              width: 30,
                              padding: const EdgeInsets.only(bottom: 10, top: 10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/logo.jpg"),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(
                                color: Colors.teal.shade50,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            alignment: Alignment.centerRight, // Align text to the right
                            child: const Text(
                              'Sample message',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Positioned TextField at the bottom
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.92,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                    hintText: 'Enter your message ...',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}



class RealTimeCounterPage extends StatefulWidget {
  @override
  _RealTimeCounterPageState createState() => _RealTimeCounterPageState();
}

class _RealTimeCounterPageState extends State<RealTimeCounterPage> {
  final String wsUrl = 'ws://192.168.2.82:8000/ws/counter/';
  late WebSocketChannel _counterChannel;
  late WebSocketChannel _timerChannel;
  late Timer _counterTimer;
  late Timer _timerTimer;
  int counter = 0;
  @override
  void initState() {
    super.initState();

    // Initialize WebSocket channels
    _counterChannel = WebSocketChannel.connect(
      Uri.parse(wsUrl),
    );

    _timerChannel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.2.82:8000/ws/timer/'),
    );

    // Send initial messages to the WebSocket servers
    _counterChannel.sink.add(jsonEncode({"action": "minus"}));
    _timerChannel.sink.add(jsonEncode({"action": "increment"}));

    // Repeatedly send messages every 5 seconds (adjust interval as needed)
    _counterTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _counterChannel.sink.add(jsonEncode({"action": "minus"}));
    });
    _timerTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _timerChannel.sink.add(jsonEncode({"action": "increment"}));
    });
  }

  @override
  void dispose() {
    // Close both WebSocket channels and cancel timers when widget is disposed
    _counterChannel.sink.close();
    _timerChannel.sink.close();
    _counterTimer.cancel();
    _timerTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
       Column(
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
                  Text("Online ${data['counter']}"),
                ],
              );
            },
          ),

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
                  Text("${data['counter']}"),
                ],
              );
            },
          ),

        ],


    );
  }
}