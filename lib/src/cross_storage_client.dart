@JS()
library cross_storage_client;

import 'dart:async';
import 'dart:html_common';

import 'package:js/js.dart';


@JS('CrossStorageClient')
class _CrossStorageClientInterop {
  external factory _CrossStorageClientInterop(String hubUrl);

  external Future<void> onConnect();
  external Future<String> get(String key);
  external Future<void> set(String key, String value);
  external Future<void> del(String key);
  
}

class CrossStorageClient {
  final _CrossStorageClientInterop _crossStorageClientInterop;
  final bool _autoConnect;

  bool _isConnected = false;

  CrossStorageClient(String hubUrl, {bool autoConnect = false})
      : this._crossStorageClientInterop = _CrossStorageClientInterop(hubUrl),
        _autoConnect = autoConnect;

  Future<void> connect() async {
    Completer<void> completer = new Completer();
    if (!_isConnected) {
      await promiseToFuture(_crossStorageClientInterop.onConnect());
        completer.complete(null);
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  Future<String> getKey(String key) async {
    if (_autoConnect) {
      await connect();
    }
    return await promiseToFuture(_crossStorageClientInterop
        .get(key));
  }

  Future<void> deleteKey(String key) async {
    if (_autoConnect) {
      await connect();
    }
    return await promiseToFuture(_crossStorageClientInterop.del(key));
  }

  Future<void> setKey(String key, String value) async {
    if (_autoConnect) {
      await connect();
    }
    await promiseToFuture(_crossStorageClientInterop
        .set(key, value));
  }
}
