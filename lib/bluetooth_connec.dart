// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:masseyhacks/BluetoothDeviceListEntry.dart';
import 'package:masseyhacks/check_beat.dart';
import 'package:masseyhacks/detail.dart';

class BluetoothHome extends StatefulWidget {
  @override
  _BluetoothHomeState createState() => _BluetoothHomeState();
}

class _BluetoothHomeState extends State<BluetoothHome>
    with WidgetsBindingObserver {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  List<BluetoothDevice> devices = List<BluetoothDevice>();

  @override
  void initState() {
    super.initState();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CheckBeat(server: BluetoothDevice(address: "dsglkj"));
    }));
    WidgetsBinding.instance.addObserver(this);
    _getBTState();
    _stateChangeListener();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0) {
      //resume
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
    }
  }

  _getBTState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
      setState(() {});
    });
  }

  _stateChangeListener() {
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _bluetoothState = state;
      if (_bluetoothState.isEnabled) {
        _listBondedDevices();
      } else {
        devices.clear();
      }
      print("State isEnabled: ${state.isEnabled}");
      setState(() {});
    });
  }

  _listBondedDevices() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(4278656558),
        body: Container(
          child: Column(
            children: <Widget>[
              SwitchListTile(
                title: Text('Enable Bluetooth',
                    style: TextStyle(color: Colors.white)),
                value: _bluetoothState.isEnabled,
                onChanged: (bool value) {
                  future() async {
                    if (value) {
                      await FlutterBluetoothSerial.instance.requestEnable();
                    } else {
                      await FlutterBluetoothSerial.instance.requestDisable();
                    }
                    future().then((_) {
                      setState(() {});
                    });
                  }
                },
              ),
              
              ListTile(
                title: Text("Bluetooth STATUS",
                    style: TextStyle(color: Colors.white)),
                subtitle: Text(
                  _bluetoothState.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                trailing: RaisedButton(
                  color: Colors.blue,
                  child:
                      Text("Settings", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    FlutterBluetoothSerial.instance.openSettings();
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  children: devices
                      .map((_device) => BluetoothDeviceListEntry(
                            device: _device,
                            enabled: true,
                            onTap: () {
                              print("Item");
                              _startCameraConnect(context, _device);
                            },
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _startCameraConnect(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CheckBeat(server: server);
    }));
  }
}
