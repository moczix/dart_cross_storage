@JS()
library cross_storage_client;

import 'dart:async';

import 'package:js/js.dart';

typedef Func1<A, R> = R Function(A a);

@JS('Promise')
class PromiseJsImpl<T> {
  external PromiseJsImpl(Function resolver);
  external PromiseJsImpl then([Func1 onResolve, Func1 onReject]);
}

@JS('CrossStorageClient')
class _CrossStorageClientInterop {
  final String _hubUrl;

  _CrossStorageClientInterop(this._hubUrl);

  external PromiseJsImpl<void> onConnect();

  external PromiseJsImpl<String> get(String key);

  external PromiseJsImpl<String> set(String key, String value);

  external PromiseJsImpl<String> del(String key);
}

class CrossStorageClient {
  final _CrossStorageClientInterop _crossStorageClientInterop;
  final bool _autoConnect;

  bool _isConnected = false;

  CrossStorageClient(String hubUrl, {bool autoConnect = false})
      : this._crossStorageClientInterop = _CrossStorageClientInterop(hubUrl),
        _autoConnect = autoConnect;

  Future<void> connect() {
    Completer<void> completer = new Completer();
    if (!_isConnected) {
      _crossStorageClientInterop.onConnect().then((_) {
        _isConnected = true;
        completer.complete(null);
      });
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  Future<String> getKey(String key) async {
    Completer<String> completer = new Completer();

    if (_autoConnect) {
      await connect();
    }

    _crossStorageClientInterop
        .get(key)
        .then((result) => completer.complete(result));
    return completer.future;
  }

  Future<void> deleteKey(String key) async {
    Completer<void> completer = new Completer();
    if (_autoConnect) {
      await connect();
    }
    _crossStorageClientInterop.get(key).then((_) => completer.complete(null));
    return completer.future;
  }

  Future<void> setKey(String key, String value) async {
    Completer<void> completer = new Completer();
    if (_autoConnect) {
      await connect();
    }
    _crossStorageClientInterop
        .set(key, value)
        .then((_) => completer.complete(null));
    return completer.future;
  }
}
