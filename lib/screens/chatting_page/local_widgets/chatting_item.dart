import 'package:flutter_firebase_chat/models/ChattingModel.dart';
import 'package:flutter_firebase_chat/screens/chatting_page/local_utils/ChattingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChattingItem extends StatelessWidget {
  const ChattingItem({required Key key, required this.chattingModel})
      : super(key: key);
  final ChattingModel chattingModel;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ChattingProvider>(context);
    var isMe = chattingModel.pk == p.pk;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: Text(
                  chattingModel.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                    color: isMe ? Colors.blue[500] : Colors.blue[800],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(isMe ? 30 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 30))),
                child: Text(
                  chattingModel.text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
