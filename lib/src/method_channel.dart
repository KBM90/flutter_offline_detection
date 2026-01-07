import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'enums.dart';
import 'platform_interface.dart';

/// An implementation of [FlutterOfflineDetectionPlatform] that uses method channels.
class MethodChannelFlutterOfflineDetection
    extends FlutterOfflineDetectionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_offline_detection');

  /// The event channel used to receive status updates.
  @visibleForTesting
  final eventChannel = const EventChannel('flutter_offline_detection/events');

  Stream<InternetStatus>? _onStatusChange;

  @override
  Stream<InternetStatus> get onStatusChange {
    _onStatusChange ??= eventChannel.receiveBroadcastStream().map((event) {
      if (event == 'connected') {
        return InternetStatus.connected;
      } else {
        return InternetStatus.disconnected;
      }
    });
    return _onStatusChange!;
  }

  @override
  Future<InternetStatus> checkNow() async {
    final status = await methodChannel.invokeMethod<String>('checkNow');
    if (status == 'connected') {
      return InternetStatus.connected;
    } else {
      return InternetStatus.disconnected;
    }
  }
}
