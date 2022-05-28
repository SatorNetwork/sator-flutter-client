import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';
import 'package:satorio/data/datasource/auth_data_source.dart';
import 'package:satorio/data/datasource/firebase_data_source.dart';

class UnityViewPage extends StatefulWidget {
  UnityViewPage() : super();

  @override
  _UnityViewPageState createState() => _UnityViewPageState();
}

class _UnityViewPageState extends State<UnityViewPage> {
  late FirebaseDataSource _firebaseDataSource;
  late UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await _unityWidgetController.pause();
          Navigator.of(context).pop();
          return false;
        }, child:
    Scaffold(
      appBar: AppBar(
        title: const Text('Sator Space'),
      ),
      body: UnityWidget(
          onUnityCreated: onUnityCreated,
          onUnityMessage: onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
          fullscreen: false,
          borderRadius: BorderRadius.zero
      ),
    ));
  }

  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  void onUnityMessage(message) {
    var data = message.toString();
    var splitted = data.split('^');
    var eventName = splitted[0];
    var parameters;

    if (splitted[1].length != 0) {
      parameters = json.decode(splitted[1]);
    }

    _firebaseDataSource.logEvent(eventName, parameters);
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    print('Received scene loaded from unity: ${scene?.name}');
    print('Received scene loaded from unity buildIndex: ${scene?.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) async  {
    _unityWidgetController = controller;

    await _unityWidgetController.pause();

    Future.delayed(
      Duration(milliseconds: 100),
          () async {
        await this._unityWidgetController.resume();
      },
    );

    _firebaseDataSource = Get.find<FirebaseDataSource>();

    var tkn = await Get.find<AuthDataSource>().getAuthToken() as String;
    var url = await _firebaseDataSource.apiBaseUrl() as String;

    _unityWidgetController.postMessage(
        'GameStarter',
        'Initialize',
        tkn + ' ' + url + 'gapi/'
    );
  }
}