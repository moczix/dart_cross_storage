## Dart wrapper for zendesk/cross_storage

this is wrapper for https://github.com/zendesk/cross-storage/


## installation:
add this to your dependencies
```
dependencies:
  cross_storage: ^1.0.0
```
## import
```
import 'package:cross_storage/cross_storage.dart';

```

## usage

```
void main() async {
  final crossStorage = CrossStorageClient('https://example.com');

  await crossStorage.connect();
  print(await crossStorage.getKey('newKey'));
}


```

## issues

1. Hub part doesnt work, it would require of forking the hub.js because there is check if origin is instanceof RegExp, and dart have diffrent RegExp for js.