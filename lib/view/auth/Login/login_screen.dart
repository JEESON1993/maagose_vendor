import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/helper/hide_keyboard.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = true;
  int otp;
  TextEditingController mobileController = new TextEditingController(text: '');
  TextEditingController passwordController =
      new TextEditingController(text: '');
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future _loginUser() async {
    if (formkey.currentState.validate()) {
      String username = mobileController.text.trim();
      String password = passwordController.text.trim();
      Map<String, dynamic> body = {"username": username, "password": password};
      Provider.of<RestaurantProvider>(context, listen: false)
          .loginUser(context, body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(window);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                height: mq.size.height,
              ),
              child: GestureDetector(
                onTap: () {
                  hideKeyboard(context);
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/bg1.jpg',
                              ))),
                      height: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x09000000),
                                    spreadRadius: 5,
                                    blurRadius: 20,
                                    offset: Offset(
                                        0, 8), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:
                                  Image.asset("assets/images/MFS VENDOR.png")),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Maafos Restaurant',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                letterSpacing: -1,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Quicksand'),
                          ),
                          Text(
                            'Manage Orders Quick and Easily.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Quicksand'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Login', style: kHeadTitle),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: MultiValidator(
                                [
                                  RequiredValidator(
                                      errorText: 'Please type username')
                                ],
                              ),
                              controller: mobileController,
                              style: kMediumText,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.grey[140],
                                  prefixStyle: kHintStyle,
                                  border: kOutlineStyle,
                                  hintText: 'Please enter username',
                                  hintStyle: kHintStyle),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: 'Password is Required'),
                              obscureText: isVisible,
                              controller: passwordController,
                              style: kMediumText,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[140],
                                  border: kOutlineStyle,
                                  hintText: 'Password',
                                  hintStyle: kHintStyle),
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Text(
                            //     'Forgot Password?',
                            //     textAlign: TextAlign.right,
                            //     style: TextStyle(
                            //         decoration: TextDecoration.underline,
                            //         color: kPrimaryColor),
                            //   ),
                            // ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [kPrimaryColor, kPrimaryColor2],
                                  begin: FractionalOffset.bottomCenter,
                                  end: FractionalOffset.topCenter,
                                ),
                              ),
                              child: TextButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _loginUser();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
