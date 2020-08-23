import 'package:chatIt/model/user.dart';
import 'package:chatIt/viewModel/homeScreen_viewmodel.dart';
import 'package:chatIt/widgets/findFriends.dart';
import 'package:chatIt/widgets/popUpMenu.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homeScreenPage';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List listOnTop = ['Chats', 'Groups'];
  int selectedno = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userEmail;

  @override
  Widget build(BuildContext context) {
    String _selection = '';
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (_) => _.checkCurrentUser(),
        createNewModelOnInsert: true,
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: kbackground,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kbackground2,
                elevation: 0,
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  PopUpMenu(
                    selection: _selection,
                    scaffoldKey: _scaffoldKey,
                  ),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(
                      top: kpadding,
                      left: kpadding,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: kbackground2,
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listOnTop.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedno = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: kpadding),
                                child: Text(
                                  listOnTop[index],
                                  style: kTextyle.copyWith(
                                      fontSize: 30,
                                      color: index == selectedno
                                          ? Colors.white
                                          : Colors.white12),
                                ),
                              ),
                            )),
                  ),
                  model.currentusers != null
                      ? StreamBuilder(
                          stream: model.fetchFriendSnapshot(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                child: Text(''),
                              );
                            }
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Users peer = snapshot.data[index];
                                    if (peer == null) {
                                      return Container();
                                    }
                                    return friendCard(
                                        context: context,
                                        peer: peer,
                                        onTap: () {
                                          model.openChatScreen(peer);
                                        },
                                        model: model);
                                  }),
                            );
                          })
                      : Container(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return RequestPage();
                      });
                },
                backgroundColor: kbackground2,
                child: Text(
                  '+',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                elevation: 2,
              ),
            ),
          );
        });
  }
}

Widget friendCard(
    {BuildContext context, Users peer, Function onTap, HomeViewModel model}) {
  final width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 2),
      color: Colors.white12,
      padding: EdgeInsets.only(top: 20, left: kpadding / 2, right: kpadding),
      child: Column(
        children: [
          StreamBuilder(
              stream: model.lastMessages(peer),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                if (snapshot.data.isEmpty) {
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(peer.imageUrl),
                        radius: 30,
                        foregroundColor: kbackground2,
                      ),
                      SizedBox(
                        width: kpadding / 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: Text(
                              '${peer.firstName} ${peer.lastName}',
                              style: kTextyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: Text(''),
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  var lastMessage = snapshot.data.reversed.last;
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(peer.imageUrl),
                        radius: 30,
                        foregroundColor: kbackground2,
                      ),
                      SizedBox(
                        width: kpadding / 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.5,
                            child: Text(
                              '${peer.firstName} ${peer.lastName}',
                              style: kTextyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                              width: width * 0.5,
                              child: lastMessage == null
                                  ? Text('')
                                  : lastMessage.type == 0
                                      ? Text(
                                          lastMessage.content,
                                          style: kTexstyleChat.copyWith(
                                              fontStyle: FontStyle.italic),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : lastMessage.type == 1
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  'image',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )
                                              ],
                                            )
                                          : Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(
                                                Icons.gif,
                                                size: 30,
                                                color: Colors.black,
                                              ),
                                            ))
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            lastMessage.time,
                            style: kTexstyleChat.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
          SizedBox(
            height: kpadding / 2,
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    ),
  );
}
