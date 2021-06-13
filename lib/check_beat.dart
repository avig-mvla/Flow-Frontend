// @dart=2.9

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:masseyhacks/detail.dart';
import 'package:masseyhacks/home.dart';
import 'package:masseyhacks/wav_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

enum RecordState { stopped, recording }

class CheckBeat extends StatefulWidget {
  final BluetoothDevice server;

  CheckBeat({this.server});

  @override
  _CheckBeatState createState() => _CheckBeatState();
}

class _CheckBeatState extends State<CheckBeat> {
  int timeLeft = 60;
//60

  Timer _timer;

  timer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(
      'username',
    );
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeLeft == 0) {
        if (mounted) {
          // Dio dio = new Dio();
          // var bytes_data = {"byes": byteData, "username": username};
          // await dio.post("https://flow-live.tech/api/send_recording",
          //     data: FormData.fromMap(bytes_data));

          _sendMessage("STOP");
          showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  backgroundColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: 350,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        //  user["result"]==null?Container():
                        LottieBuilder.network(
                          "https://assets8.lottiefiles.com/packages/lf20_qt1NKX.json",
                        ),
                        //  user["result"]==null?Container():
                        Text("Normal Heartbeat",
                            style: GoogleFonts.poppins(
                              fontSize: 23,
                              color: Color(0xFFFF4848),
                            ))
                      ],
                    ),
                  ),
                );
              });

          setState(() {
            timer.cancel();
            // Navigator.pop(context);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            timeLeft--;
          });
        }
      }

      if (timeLeft == 55) {
        _sendMessage("START");
      }
    });
  }

  void _sendMessage(String text) async {
    text = text.trim();
    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text));
        await connection.output.allSent;

        if (text == "START") {
          _recordState = RecordState.recording;
        } else if (text == "STOP") {
          _recordState = RecordState.stopped;
        }
        setState(() {});
      } catch (e) {
        setState(() {});
      }
    }
  }

  BluetoothConnection connection;
  bool isConnecting = true;

  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;

  List<List<int>> chunks = <List<int>>[];
  int contentLength = 0;
  // Uint8List _bytes;

  RestartableTimer worker;
  RecordState _recordState = RecordState.stopped;

  @override
  void initState() {
    super.initState();
    _getBTConnection();

    timer();
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    _timer.cancel();
    super.dispose();
  }

  _getBTConnection() {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      connection = _connection;
      isConnecting = false;
      isDisconnecting = false;
      setState(() {});
      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally');
        } else {
          print('Disconnecting remotely');
        }
        if (this.mounted) {
          setState(() {});
        }
        Navigator.of(context).pop();
      });
    }).catchError((error) {
      Navigator.of(context).pop();
    });
  }

  var byteData = [];
  void _onDataReceived(Uint8List data) {
    if (data != null && data.length > 0) {
      print(utf8.decode(data));
      setState(() {
        byteData.add(utf8.decode(data));
      });
      // chunks.add(data);
      // contentLength += data.length;
      // _timer.reset();
    }

    print("Data Length: ${data.length}, chunks: ${chunks.length}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(4278656558),
          body: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hold on ",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            )),
                        Text("We are analyzing . . . . ",
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                height: 1.2,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 260,
                      width: 260,
                      child: Lottie.asset("assets/ecg.json",
                          frameRate: FrameRate.max),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.4))),
                ),
              ),
              SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      // time_left.toString()

                      timeLeft.toString(),
                      style: TextStyle(
                          fontSize: 60,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 5),
                    child: Text("sec",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) => Home()),
                      (route) => false);
                },
                child: Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue)),
                      child: Icon(
                        Icons.close_rounded,
                        size: 34,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          )),
    );
  }
}
