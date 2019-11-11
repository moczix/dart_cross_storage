@JS()
library cross_storage_hub;

import 'package:js/js.dart';

@JS()
@anonymous
class CrossStorageHubSettings {
  external RegExp get origin;
  external set origin(RegExp value);
  external List<String> get allow;
  external set allow(List<String> value);
  external factory CrossStorageHubSettings(
      {RegExp origin = null, List<String> allow = null});
}

@JS('CrossStorageHub')
class CrossStorageHub {
  external static init(List<CrossStorageHubSettings> options);
}
