import 'package:chatIt/viewModel/loginScreen_viewModel.dart';
import 'package:chatIt/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return Loading();
          }
          return SafeArea(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Chat_It'),
                  actions: [
                    FlatButton.icon(
                        onPressed: () {
                          model.navigate();
                        },
                        icon: Icon(
                          Icons.contacts,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: kpadding),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Text(
                          'Login to Chat',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        SizedBox(
                          height: kpadding,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: kinputDecoration.copyWith(
                              labelText: 'E-mail',
                            )),
                        SizedBox(
                          height: kpadding,
                        ),
                        TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kinputDecoration.copyWith(
                              labelText: 'Password',
                            )),
                        SizedBox(
                          height: kpadding / 5,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'forgot password?......',
                            style: TextStyle(
                                fontSize: 13, fontStyle: FontStyle.italic),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            onPressed: () async {
                              model.login(email: email, password: password);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: kbackground2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
