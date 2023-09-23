import 'dart:async';
import 'dart:isolate';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/foundation.dart';


class NetworkChecker {
  Future<bool> checkInternetConnectivity() async {
    Completer<bool> completer = Completer<bool>();

    if (!kIsWeb) {
      ReceivePort receivePort = ReceivePort();
      Isolate.spawn(_isolate, receivePort.sendPort);

      receivePort.listen((result) {
        completer.complete(result);
        receivePort.close();
      });
    } else {
      completer.complete(true);
    }

    return completer.future;
  }

  void _isolate(SendPort sendPort) async {
    bool isConnected = await DataConnectionChecker().hasConnection;
    sendPort.send(isConnected);
  }


}
