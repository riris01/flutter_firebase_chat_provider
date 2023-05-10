import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_firebase_chat/screens/chatting_page/chatting_page.dart';
import 'package:flutter_firebase_chat/screens/chatting_page/local_utils/ChattingProvider.dart';

class EntrancePage extends StatefulWidget {
  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text('Berry talk'),
          centerTitle: true,
          backgroundColor: Colors.blue[600],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your nickname',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  var u = Uuid().v1();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                            create: (context) =>
                                ChattingProvider(u, _controller.text),
                            child: ChattingPage(),
                          )));
                },
                child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      'Enter the room',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
