import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_firebase_chat/screens/chatting_page/local_widgets/chatting_item.dart';
import 'package:flutter_firebase_chat/models/ChattingModel.dart';
import 'package:flutter_firebase_chat/screens/chatting_page/local_utils/ChattingProvider.dart';
import 'package:provider/provider.dart';

class ChattingPage extends StatefulWidget {
  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late TextEditingController _controller;
  late StreamSubscription _streamSubscription;

  bool firstLoad = true;
  @override
  void initState() {
    _controller = TextEditingController();
    final p = Provider.of<ChattingProvider>(context, listen: false);
    _streamSubscription = p.getSnapshot().listen((event) {
      if (firstLoad) {
        firstLoad = false;
        return;
      }
      p.addOne(ChattingModel.fromJson(event.docs[0].data()
          as Map<String, dynamic>)); //Map<String, dynmamic>은 형변환을 하기 위한 역할을 함
    });
    Future.microtask(() {
      p.load();
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ChattingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              children: p.chattingList
                  .map((e) => ChattingItem(
                        chattingModel: e,
                        key: ValueKey(e), // 해당부분 수정
                      ))
                  .toList(),
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 1.5,
            color: Colors.grey[300],
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .5),
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      keyboardType: TextInputType.text, //Single line으로 만듦
                      style: TextStyle(fontSize: 16),
                      onSubmitted: (text) {
                        _controller.clear();
                        p.send(text);
                      }, // Enter입력시 채팅 메시지 전송 가능
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Input your text',
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var text = _controller.text;
                    _controller.text = '';
                    p.send(text);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Icon(
                      Icons.send,
                      size: 33,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
