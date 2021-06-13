import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:masseyhacks/check_beat.dart';
import 'dart:ui';
import 'package:masseyhacks/profile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_charts/src/sparkline/series/spark_area_base.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4278656558),
      body: Stack(
        alignment: Alignment.bottomCenter,
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
                                  )),
                              Text("Dhanush Vardhan ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 23.5,
                                      height: 1.5,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (c) => Profile()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://image.shutterstock.com/mosaic_250/2780032/1548802709/stock-photo-headshot-portrait-of-happy-millennial-man-in-casual-clothes-isolated-on-grey-studio-background-1548802709.jpg"))))),
                          )
                        ],
                      ),
                      SizedBox(height: 0),
                      ListView.separated(
                        separatorBuilder: (ctx, i) {
                          return SizedBox(height: 20);
                        },
                        itemCount: 10,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(0.1),
                                //     spreadRadius: 0.7,
                                //     blurRadius: 20,
                                //     offset: Offset(
                                //         0, 3), // changes position of shadow
                                //   ),
                                // ],
                                color: Colors.lightBlue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,

                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://t4.ftcdn.net/jpg/02/14/74/61/360_F_214746128_31JkeaP6rU0NzzzdFC4khGkmqc8noe6h.jpg")),
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                116,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Paul Wilson",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 21,
                                                      color: Colors.white),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              backgroundColor:
                                                                  Color(
                                                                      4278656558),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                height: 220,
                                                                width: double
                                                                    .infinity,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          13.0,
                                                                      right:
                                                                          13),
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        child: SfSparkAreaChart(
                                                                            borderColor: Color(0xFFFF4848),
                                                                            borderWidth: 1,
                                                                            axisLineColor: Colors.transparent,
                                                                            color: Color(
                                                                              0xFFFF4848,
                                                                            ).withOpacity(0.2),
                                                                            //Enable the trackball
                                                                            trackball: SparkChartTrackball(
                                                                              activationMode: SparkChartActivationMode.tap,
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            //Enable marker
                                                                            marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.none),
                                                                            //Enable data label
                                                                            labelDisplayMode: SparkChartLabelDisplayMode.none,
                                                                            data: [
                                                                              33,
                                                                              133,
                                                                              3,
                                                                              33,
                                                                              3,
                                                                              33,
                                                                              3,
                                                                              3,
                                                                              3,
                                                                              3,
                                                                              43,
                                                                              43,
                                                                              44,
                                                                              32,
                                                                              54,
                                                                              56,
                                                                              87,
                                                                              56,
                                                                              33,
                                                                              77,
                                                                              43,
                                                                              45,
                                                                              53,
                                                                              53,
                                                                              55,
                                                                              32,
                                                                              42,
                                                                              45,
                                                                              66,
                                                                              43,
                                                                              54
                                                                            ]),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                      Text(
                                                                          "Normal Heartbeat",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                23,
                                                                            color:
                                                                                Color(0xFFFF4848),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                        });
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.blue)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          size: 20,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  116,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.blue,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Call Patient",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
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
