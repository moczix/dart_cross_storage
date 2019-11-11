import 'package:cross_storage/cross_storage.dart';

void main() async {
  final crossStorage = CrossStorageClient('https://example.com');

  await crossStorage.connect();
  print(await crossStorage.getKey('newKey'));
}
