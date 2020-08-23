import 'package:chatIt/viewModel/chatScreen_veiwModel.dart';
import 'package:chatIt/widgets/chatInputs.dart';
import 'package:chatIt/widgets/chatOutput.dart';
import 'package:chatIt/widgets/gif.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

class ChatPageScreen extends StatefulWidget {
  final List groupChatId;

  const ChatPageScreen({Key key, this.groupChatId}) : super(key: key);
  @override
  _ChatPageScreenState createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  bool isLoading;
  bool isShowSticker;

  void onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isShowSticker = false;
    focusNode.addListener(onFocusChange);
  }

  void getSticker() {
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<ChatScreenViewmodel>.reactive(
      viewModelBuilder: () => ChatScreenViewmodel(),
      onModelReady: (_) => _.changeId(widget.groupChatId[0]),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kbackground,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context)),
          elevation: 1,
          backgroundColor: kbackground2,
          actions: [
            Container(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                foregroundColor: Colors.red,
                backgroundImage: (widget.groupChatId[1].imageUrl == null)
                    ? AssetImage('assets/images/images.png')
                    : NetworkImage(widget.groupChatId[1].imageUrl),
              ),
            ),
          ],
          title: Text(
            '${widget.groupChatId[1].firstName} ${widget.groupChatId[1].lastName}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                StreamBuilder(
                    stream: model.chatSnapshots(widget.groupChatId[0]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return Expanded(
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            controller: listScrollController,
                            reverse: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return chatOutPut(
                                  message: snapshot.data[index],
                                  model: ChatScreenViewmodel(),
                                  width: width);
                            }),
                      );
                    }),
                (isShowSticker ? gifBuild(model) : Container()),
                inputContainer(
                    model, focusNode, textEditingController, getSticker),
              ],
            ),
            model.isBusy ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
