import 'dart:async';

import 'src/enums.dart';
import 'src/platform_interface.dart';

export 'src/enums.dart';

class FlutterOfflineDetection {
  /// Returns a stream of [InternetStatus] that emits ONLY when the status changes.
  static Stream<InternetStatus> get onStatusChange =>
      FlutterOfflineDetectionPlatform.instance.onStatusChange.distinct();

  /// Checks the current internet status immediately.
  static Future<InternetStatus> checkNow() {
    return FlutterOfflineDetectionPlatform.instance.checkNow();
  }
}
