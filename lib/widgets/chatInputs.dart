import 'package:chatIt/viewModel/chatScreen_veiwModel.dart';
import 'package:flutter/material.dart';

Container inputContainer(ChatScreenViewmodel model, FocusNode focusNode,
    TextEditingController textEditingController, Function getSticker) {
  return Container(
    child: Row(
      children: [
        IconButton(icon: Icon(Icons.image), onPressed: () => model.getImage()),
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.gif,
          ),
          onPressed: getSticker,
        ),
        Flexible(
          child: TextField(
            focusNode: focusNode,
            controller: textEditingController,
            decoration: InputDecoration.collapsed(hintText: 'Send a message'),
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                model.sendMessages(textEditingController.text);
                textEditingController.clear();
              },
            )),
      ],
    ),
  );
}
