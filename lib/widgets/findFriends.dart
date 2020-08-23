import 'package:chatIt/model/user.dart';
import 'package:chatIt/viewModel/findFriends_veiwmodel.dart';
import 'package:chatIt/widgets/loading2.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  TextEditingController _text = TextEditingController();

  String email = '';

  bool check = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => SearchViewModel(),
        builder: (context, model, child) {
          return Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: _text,
                    decoration:
                        kinputDecoration.copyWith(hintText: 'Enter Email '),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Center(
                  child: FlatButton.icon(
                    onPressed: () async {
                      check = await model.searchFriends(_text.text);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    label: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    color: kbackground2,
                  ),
                ),
                model.isBusy
                    ? Center(child: loading2())
                    : check
                        ? UserSearch(
                            width: width,
                            user: model.user,
                          )
                        : Center(child: Text('Enter a Valid Email')),
              ],
            ),
          );
        });
  }
}

class UserSearch extends StatelessWidget {
  final Users user;
  final double width;
  UserSearch({Key key, this.user, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => SearchViewModel(),
        builder: (context, model, child) {
          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: AlertDialog(
                          backgroundColor: kbackground,
                          elevation: 2,
                          title: Text('Friend Request'),
                          content: Text(
                              'Are you sure want to send a friend request?...'),
                          actions: [
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () async {
                                model.sendRequest(user);
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 2),
                color: Colors.white12,
                padding: EdgeInsets.only(
                    top: 20, left: kpadding / 2, right: kpadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: user.imageUrl == null
                              ? AssetImage('assets/images/images.png')
                              : NetworkImage(user.imageUrl),
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
                              width: width * 0.7,
                              child: Text(
                                '${user.firstName} ${user.lastName}',
                                style: kTextyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.6,
                              child: Text(
                                user.email,
                                style: kTexstyleChat.copyWith(
                                    fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        // Spacer(),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       '7:15pm',
                        //       style: kTexstyleChat.copyWith(fontSize: 14),
                        //     ),
                        //     SizedBox(
                        //       height: 10,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
