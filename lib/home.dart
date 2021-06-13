// @dart=2.9

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:fade/fade.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:masseyhacks/bluetooth_connec.dart';
import 'package:masseyhacks/check_beat.dart';
import 'package:masseyhacks/device_list.dart';
import 'package:masseyhacks/doctor_home.dart';
import 'dart:ui';

import 'package:masseyhacks/profile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio = new Dio();
  bool issee = false;

  Map<String, dynamic> user = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_type();
  }

  List recordings;

  get_type() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var username = prefs.getString("username");
    dio.get(Config.base_url + "/users/${username}").then((value) {
      setState(() {
        user = value.data;
      });
      recordings = user["recordings"];
      var recording = (recordings[0]);
      print("Recording: " + recording.toString());

      setState(() {
        user_Type = user["user_type"];
      });
    });
  }

  String user_Type;
  @override
  Widget build(BuildContext context) {
    return user_Type == "Doctor"
        ? DoctorHome()
        : Scaffold(
            backgroundColor: Color(4278656558),
            body: Stack(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height - 90,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          left: 8.0,
                          top: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hello There ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 23.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                    user["name"] == null
                                        ? Container()
                                        : Text(user["name"],
                                            style: GoogleFonts.poppins(
                                                fontSize: 23.5,
                                                height: 1.5,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => Profile()));
                                  },
                                  //profile picture
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg")))),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 0),
                            //recordings list view
                            ListView.separated(
                              separatorBuilder: (ctx, i) {
                                return SizedBox(height: 20);
                              },
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 70,

                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/wave.png")),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              // child:
                                              //   Image.network(name),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 16),
                                                recordings == null
                                                    ? Container()
                                                    : Text(
                                                        recordings[index]
                                                            .toString()
                                                            .substring(
                                                                106,
                                                                recordings[index]
                                                                        .toString()
                                                                        .length -
                                                                    2),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 21,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                SizedBox(height: 8),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      119,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "6/13/21",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showBarModalBottomSheet(
                                                              backgroundColor:
                                                                  Color(
                                                                      4278656558),
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Container(
                                                                  color: Color(
                                                                      4278656558),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              15.0,
                                                                          right:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Text(
                                                                            "Share it with your doctor",
                                                                            style: GoogleFonts.poppins(
                                                                                fontSize: 23,
                                                                                color: Colors.blue,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              bottom: 22.0,
                                                                            ),
                                                                            //Doctors
                                                                            child:
                                                                                ListView.separated(
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              separatorBuilder: (ctx, i) {
                                                                                return SizedBox(height: 20);
                                                                              },
                                                                              itemCount: 1,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (BuildContext context, int i) {
                                                                                return Container(
                                                                                    width: double.infinity,
                                                                                    height: 100,
                                                                                    decoration: BoxDecoration(
                                                                                      // boxShadow: [
                                                                                      //   BoxShadow(
                                                                                      //     color: Colors.black.withOpacity(0.1),
                                                                                      //     spreadRadius: 0.3,
                                                                                      //     blurRadius: 10,
                                                                                      //     offset: Offset(0, 3), // changes position of shadow
                                                                                      //   ),
                                                                                      // ],
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                      color: Colors.lightBlue.withOpacity(0.2),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                                                                                      child: Center(
                                                                                        child: Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: 80,

                                                                                              height: 80,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.grey.withOpacity(0.2),
                                                                                                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg")),
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                              ),
                                                                                              // child:
                                                                                              //   Image.network(name),
                                                                                            ),
                                                                                            SizedBox(width: 10),
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                SizedBox(height: 16),
                                                                                                Text(
                                                                                                  "Dr. Dhanush Vardhan",
                                                                                                  style: GoogleFonts.poppins(fontSize: 21, color: Colors.white),
                                                                                                ),
                                                                                                SizedBox(height: 5),
                                                                                                GestureDetector(
                                                                                                  onTap: () async {
                                                                                                    Navigator.pop(context);
//
                                                                                                    showDialog(
                                                                                                        context: context,
                                                                                                        builder: (context) {
                                                                                                          Future.delayed(Duration(seconds: 3), () {
                                                                                                            Navigator.of(context).pop(true);
                                                                                                          });
                                                                                                          return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: Colors.grey[900], child: Container(width: 200, height: 130, child: Lottie.asset("assets/tick.json", repeat: false)));
                                                                                                        });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                      width: MediaQuery.of(context).size.width - 136,
                                                                                                      height: 30,
                                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                          "Send",
                                                                                                          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 17),
                                                                                                        ),
                                                                                                      )),
                                                                                                ),
                                                                                              ],
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        child: Icon(
                                                          Icons.share,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //     height: 80,
                //     width: double.infinity,
                //     child: Stack(
                //       alignment: Alignment.center,
                //       children: [
                //         Container(
                //           height: 80,
                //           width: double.infinity,
                //           color: Colors.pink,
                //           child: BackdropFilter(
                //             filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //             child: Container(
                //               height: 80,
                //               width: double.infinity,
                //               color: Colors.pink,
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(bottom: .0),
                //           child: Container(
                //             width: MediaQuery.of(context).size.width - 10,
                //             height: 50,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: Color(4279980225)),
                //             child: Center(
                //               child: Text(
                //                 "Call Doctor",
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontSize: 20,
                //                     fontWeight: FontWeight.w500),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     )),
                Align(
                  alignment: Alignment.topCenter,
                  child: Fade(
                    visible: issee,
                    duration: Duration(milliseconds: 100),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 10,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[900]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg"),
                                          fit: BoxFit.cover)),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GradientText(
                                    text: "Dr. Nethan Swe",
                                    colors: [Colors.white, Colors.white],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        color: Colors.orange),
                                  ),
                                  //  GoogleFonts.poppins(
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 20,
                                  //       color: Colors.orange),
                                  SizedBox(height: 1),
                                  Text(
                                    "17/12/21",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (builder) =>
                                      //         Profile(useruid, location, foodphoto)));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 190,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          gradient: LinearGradient(colors: [
                                            Colors.blue,
                                            Colors.lightBlueAccent
                                          ])),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Attend Call',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => BluetoothHome()));
                    },
                    child: new ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: new BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: new Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                          ),
                          width: double.infinity,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Colors.lightBlueAccent
                                ])),
                            child: Center(
                              child: Text(
                                "Analayse Heartbeat",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // bottomNavigationBar: Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width - 10,
            //     height: 50,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Color(4279980225)),
            //     child: Center(
            //       child: Text(
            //         "Call Doctor",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ),
            //   ),
            // ),
          );
  }
}
