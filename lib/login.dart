import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:masseyhacks/home.dart';
import 'package:masseyhacks/signinup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(4278656558),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child:
                      Image.asset("assets/blob.png", height: 220, width: 220)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 200, right: 210),
                      child:
                          // Text('Login',
                          //     style: GoogleFonts.poppins(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black87)),
                          GradientText(
                              text: "Login",
                              colors: [Colors.blue, Colors.lightBlueAccent],
                              style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))),
                  Padding(
                    padding: const EdgeInsets.only(right: 125),
                    child: Text('Please login to continue',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(4288914861))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 30, right: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Username',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                color: Color(4288914861), fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 2,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black12,
                              //     blurRadius: 6.0,
                              //     offset: Offset(0, 2),
                              //   ),
                              // ],
                            ),
                            child: TextFormField(
                                controller: _username,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Color(4288914861),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                  color: Color(4288914861), fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 3,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              controller: _password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color(4288914861),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                Dio dio = new Dio();
                                var password = {"password": _password.text};
                                var res = await dio.post(
                                    Config.base_url + "/login/${_username.text}",
                                    data: FormData.fromMap(password));
                                if (res.data == "True") {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'username', _username.text);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => Home()),
                                      (route) => false);
                                } else {
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 180,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Login ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.lightBlueAccent
                                  ])),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Signup()));
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Text('Dont have an account ?',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(4288914861))),
                          ),
                          GradientText(
                              text: "  SignUp",
                              colors: [Colors.blue, Colors.lightBlueAccent],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(4288914861))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
