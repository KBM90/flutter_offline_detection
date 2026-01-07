import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enums.dart';
import 'method_channel.dart';

abstract class FlutterOfflineDetectionPlatform extends PlatformInterface {
  /// Constructs a FlutterOfflineDetectionPlatform.
  FlutterOfflineDetectionPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterOfflineDetectionPlatform _instance =
      MethodChannelFlutterOfflineDetection();

  /// The default instance of [FlutterOfflineDetectionPlatform] to use.
  ///
  /// Defaults to [_PlaceholderImplementation].
  static FlutterOfflineDetectionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterOfflineDetectionPlatform] when
  /// they register themselves.
  static set instance(FlutterOfflineDetectionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<InternetStatus> get onStatusChange {
    throw UnimplementedError('onStatusChange has not been implemented.');
  }

  Future<InternetStatus> checkNow() {
    throw UnimplementedError('checkNow() has not been implemented.');
  }
}
