import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:altto_app/components/globals.dart' as globals;
import 'dart:convert'; // to use ASCII

const String forward = '/forward';
const String backward = '/backward';
const String up = '/upward';
const String down = '/downward';
const String stop = '/stop';

void sendCommand(String username, String password, String command,
    BuildContext context) async {

  try {
    await Dio().get('http://192.168.1.184$command');
  } catch (e) {
    if (e.toString() ==
        'DioError [DioErrorType.RESPONSE]: Http status error [401]') {
      //todo error connection handling
      Toast.show('Erro de Login. Verifique credenciais', context,
          duration: Toast.LENGTH_LONG);
    }
    /*else if (e != null) {
      Toast.show(e.toString(), context, duration: Toast.LENGTH_LONG);
    }*/
  }
}

bool sendBluetoothCommand(String command,
                          BuildContext context) {
  try {
    globals.connection.output.add(ascii.encode(command));
    return true;
  }
  catch (exception) {
    Toast.show('${exception}', context);
    return false;
  }
}