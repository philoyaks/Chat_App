import 'package:chatIt/model/user.dart';
import 'package:chatIt/viewModel/friendrequest_viewmodel.dart';
import 'package:chatIt/widgets/loading2.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../constants.dart';

class FriendRequest extends StatefulWidget {
  final email;

  const FriendRequest({Key key, this.email}) : super(key: key);

  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<FriendRequestViewModel>.reactive(
        viewModelBuilder: () => FriendRequestViewModel(),
        onModelReady: (_) => _.checkLogin(),
        createNewModelOnInsert: true,
        builder: (context, model, child) {
          return Container(
            width: width,
            color: kbackground2.withOpacity(.7),
            height: height * 0.6,
            padding: EdgeInsets.only(top: kpadding),
            child: Column(
              children: [
                Text(
                  'Friend Request',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                StreamBuilder(
                    stream: model.friendSnapshot(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return loading2();
                      }
                      if (snapshot.data.isEmpty) {
                        return SizedBox(
                            height: 60,
                            child: Text(
                              'No Friend request available...',
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ));
                      }
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Users user = snapshot.data[index];
                              return requestCard(
                                  width: width,
                                  user: user,
                                  decline: () {
                                    model.declineFriendRequest(user.email);
                                  },
                                  accept: () async {
                                    await model.acceptFriendRequest(
                                        user.email, user);
                                  });
                            }),
                      );
                    }),
              ],
            ),
          );
        });
  }
}

Widget requestCard(
    {@required double width,
    @required Users user,
    @required Function decline,
    @required Function accept}) {
  return Card(
    elevation: 2,
    color: Colors.white10,
    child: Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: user.imageUrl != null
                    ? NetworkImage(user.imageUrl)
                    : AssetImage('assets/images/images.png'),
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
                      '${user.email}',
                      style: kTextyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color: Colors.green[900],
                icon: Icon(Icons.check),
                onPressed: accept,
              ),
              IconButton(
                color: Colors.red[900],
                icon: Icon(Icons.close),
                onPressed: decline,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
