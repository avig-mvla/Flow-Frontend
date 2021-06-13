import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:masseyhacks/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _userType = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 200, left: 20),
                      child:
                          // Text('Login',
                          //     style: GoogleFonts.poppins(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black87)),
                          GradientText(
                              text: "SignUp",
                              colors: [Colors.blue, Colors.lightBlueAccent],
                              style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Please signup to continue',
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
                            'Name',
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
                                controller: _name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
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
                              'Email',
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
                              ),
                            ),
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
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Age',
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
                              controller: _age,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: Color(4288914861),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'User Type',
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
                              controller: _userType,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person_pin,
                                  color: Color(4288914861),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              Dio dio = Dio();
                              var data = {
                                "name": _name.text,
                                "age": _age.text,
                                "username": _username.text,
                                "password": _password.text,
                                "user_type": _userType.text,
                                "doctors": [],

                                "recordings": [],
                              };
                              var res = await dio.post(
                                  "https://flow-live.tech/api/register_user",
                                  data: FormData.fromMap(data));
                              if (res.data == "Success") {
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
                                print(res);
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
                                        'SignUp ',
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
                        SizedBox(
                          height: 20,
                        )
                      ],
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
