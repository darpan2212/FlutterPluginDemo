import 'dart:async';

import 'package:developer_module/developer_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _isDeveloperModeEnable = false;
  String _apiRes = 'Click on CallAPI button';
  final _developerModulePlugin = DeveloperModule();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool isDeveloperModeEnable;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _developerModulePlugin.getPlatformVersion() ??
          'Unknown platform version';
      isDeveloperModeEnable =
          await _developerModulePlugin.isDeveloperOptionEnable() ?? false;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      isDeveloperModeEnable = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _isDeveloperModeEnable = isDeveloperModeEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                  'Running on: $_platformVersion\nDeveloper mode : $_isDeveloperModeEnable'),
            ),
            ElevatedButton(
              onPressed: getApiResponse,
              child: const Text('CallAPI'),
            ),
            Text(_apiRes),
          ],
        ),
      ),
    );
  }

  getApiResponse() async {
    String response = "";

    await _developerModulePlugin.getList().then((value) => {
      response = value!
    }).catchError((onError)=>{
      response = onError.toString()
    });

    setState(() {
      _apiRes = response;
    });
  }
}
