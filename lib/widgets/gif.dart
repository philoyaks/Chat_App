import 'package:chatIt/viewModel/chatScreen_veiwModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget gifBuild(ChatScreenViewmodel model) {
  return Container(
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () => model.onSendMessage('sticker1', 2),
              child: Image.asset(
                'assets/gif/sticker1.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => model.onSendMessage('sticker2', 2),
              child: Image.asset(
                'assets/gif/sticker2.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => model.onSendMessage('sticker3', 2),
              child: Image.asset(
                'assets/gif/sticker3.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () => model.onSendMessage('sticker4', 2),
              child: Image.asset(
                'assets/gif/sticker4.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => model.onSendMessage('sticker5', 2),
              child: Image.asset(
                'assets/gif/sticker5.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => model.onSendMessage('sticker6', 2),
              child: Image.asset(
                'assets/gif/sticker6.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Row(
          children: <Widget>[
            FlatButton(
              onPressed: () => model.onSendMessage('sticker7', 2),
              child: Image.asset(
                'assets/gif/sticker7.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => model.onSendMessage('sticker8', 2),
              child: Image.asset(
                'assets/gif/sticker8.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            ),
            FlatButton(
              onPressed: () => model.onSendMessage('sticker9', 2),
              child: Image.asset(
                'assets/gif/sticker9.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ),
    decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.blue, width: 0.5)),
        color: Colors.white),
    padding: EdgeInsets.all(5.0),
    height: 180.0,
  );
}
