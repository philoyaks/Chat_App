import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatIt/constants.dart';
import 'package:chatIt/model/messages.dart';
import 'package:chatIt/viewModel/chatScreen_veiwModel.dart';
import 'package:flutter/material.dart';

Widget chatOutPut({Message message, ChatScreenViewmodel model, var width}) {
  if (message.senderId == model.currentUser()) {
    return Row(
      children: <Widget>[
        message.type == 0
            // Text
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.content,
                      style: TextStyle(color: Colors.white),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        message.time,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: width * 0.6,
                decoration: BoxDecoration(
                    color: kinpColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
              )
            : message.type == 1
                // Image
                ? Container(
                    child: FlatButton(
                      child: Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kbackground2),
                            ),
                            width: 200.0,
                            height: 200.0,
                            padding: EdgeInsets.all(70.0),
                            decoration: BoxDecoration(
                              color: kinpColor2,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Material(
                            child: Image.asset(
                              'images/img_not_available.jpeg',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                          imageUrl: message.content,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
                      },
                      padding: EdgeInsets.all(0),
                    ),
                    margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
                  )
                // Sticker
                : Container(
                    child: Image.asset(
                      'assets/gif/${message.content}.gif',
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                    margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
                  ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  } else {
    // Left (peer message)
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // isLastMessageLeft(index)
              //     ? Material(
              //         child: CachedNetworkImage(
              //           placeholder: (context, url) => Container(
              //             child: CircularProgressIndicator(
              //               strokeWidth: 1.0,
              //               valueColor:
              //                   AlwaysStoppedAnimation<Color>(Colors.amber),
              //             ),
              //             width: 35.0,
              //             height: 35.0,
              //             padding: EdgeInsets.all(10.0),
              //           ),
              //           imageUrl: peerAvatar,
              //           width: 35.0,
              //           height: 35.0,
              //           fit: BoxFit.cover,
              //         ),
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(18.0),
              //         ),
              //         clipBehavior: Clip.hardEdge,
              //       )
              //     : Container(width: 35.0),
              message.type == 0
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.content,
                            style: TextStyle(color: Colors.white),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              message.time,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      width: width * 0.6,
                      decoration: BoxDecoration(
                          color: kbackground2,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      margin: EdgeInsets.only(left: 10.0),
                    )
                  : message.type == 1
                      ? Container(
                          child: FlatButton(
                            child: Material(
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kbackground),
                                  ),
                                  width: 200.0,
                                  height: 200.0,
                                  padding: EdgeInsets.all(70.0),
                                  decoration: BoxDecoration(
                                    color: kinpColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'images/img_not_available.jpeg',
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: message.content,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
                            },
                            padding: EdgeInsets.all(0),
                          ),
                          margin: EdgeInsets.only(left: 10.0),
                        )
                      : Container(
                          child: Image.asset(
                            'assets/gif/${message.content}.gif',
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              bottom: 10.0, right: 10.0, left: 10),
                        ),
            ],
          ),

          // Time
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
