import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_offline_detection/flutter_offline_detection.dart';
import 'package:flutter_offline_detection/src/platform_interface.dart';
import 'package:flutter_offline_detection/src/method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterOfflineDetectionPlatform
    with MockPlatformInterfaceMixin
    implements FlutterOfflineDetectionPlatform {
  @override
  Future<InternetStatus> checkNow() => Future.value(InternetStatus.connected);

  @override
  Stream<InternetStatus> get onStatusChange =>
      Stream.value(InternetStatus.connected);
}

void main() {
  final FlutterOfflineDetectionPlatform initialPlatform =
      FlutterOfflineDetectionPlatform.instance;

  test('$MethodChannelFlutterOfflineDetection is the default instance', () {
    expect(
      initialPlatform,
      isInstanceOf<MethodChannelFlutterOfflineDetection>(),
    );
  });

  test('checkNow', () async {
    MockFlutterOfflineDetectionPlatform fakePlatform =
        MockFlutterOfflineDetectionPlatform();
    FlutterOfflineDetectionPlatform.instance = fakePlatform;

    expect(await FlutterOfflineDetection.checkNow(), InternetStatus.connected);
  });
}
