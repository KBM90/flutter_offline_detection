import 'package:flutter/services.dart';
import 'package:flutter_offline_detection/src/method_channel.dart';
import 'package:flutter_offline_detection/src/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterOfflineDetection platform =
      MethodChannelFlutterOfflineDetection();
  const MethodChannel channel = MethodChannel('flutter_offline_detection');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return 'connected';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('checkNow', () async {
    expect(await platform.checkNow(), InternetStatus.connected);
  });
}
