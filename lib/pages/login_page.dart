import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_homeward/ProgressHUD.dart';
import 'package:flutter_homeward/api/api_service.dart';
import 'package:flutter_homeward/model/login_model.dart';
import 'package:flutter_homeward/pages/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

  bool hidepassword = true;

  LoginRequestModel loginRequestModel;

  bool isApicallProcess = false;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApicallProcess,
      opcaity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ]),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => loginRequestModel.email = input,
                        validator: (input) => !input.contains("@")
                            ? "Email Id should be valid"
                            : null,
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2),
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).accentColor,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => loginRequestModel.password = input,
                        validator: (input) => input.length < 3
                            ? "Password should be more than 3 characters"
                            : null,
                        obscureText: hidepassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2),
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidepassword = !hidepassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidepassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FlatButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 80,
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            print(loginRequestModel.toJson());
                            setState(() {
                              isApicallProcess = true;
                            });

                            APIService apiService = new APIService();
                            apiService.login(loginRequestModel).then((value) {
                              if (value != null) {
                                setState(() {
                                  isApicallProcess = false;
                                });

                                if (value.token.isNotEmpty) {
                                  final snackBar = SnackBar(
                                    content: Text("Login Successful"),
                                  );

                                  scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                  print(value.token);

                                  var k = value.token;

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                          settings:
                                              RouteSettings(arguments: k)));
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text(value.error),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                }
                              }
                            });
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
