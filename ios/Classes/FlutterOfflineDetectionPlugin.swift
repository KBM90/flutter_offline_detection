import Flutter
import UIKit
import Network

@available(iOS 12.0, *)
public class FlutterOfflineDetectionPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?
  private var monitor: NWPathMonitor?
  private let queue = DispatchQueue(label: "com.example.flutter_offline_detection.monitor")

  override init() {
    super.init()
    startMonitor()
  }

  private func startMonitor() {
      if monitor == nil {
          monitor = NWPathMonitor()
          monitor?.pathUpdateHandler = { [weak self] path in
              let status = path.status == .satisfied ? "connected" : "disconnected"
              DispatchQueue.main.async {
                  self?.eventSink?(status)
              }
          }
          monitor?.start(queue: queue)
      }
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_offline_detection", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "flutter_offline_detection/events", binaryMessenger: registrar.messenger())
    
    let instance = FlutterOfflineDetectionPlugin()
    
    registrar.addMethodCallDelegate(instance, channel: channel)
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "checkNow" {
      if let path = monitor?.currentPath {
          result(path.status == .satisfied ? "connected" : "disconnected")
      } else {
          result("disconnected")
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
  
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    // Send current status immediately
    if let path = monitor?.currentPath {
        events(path.status == .satisfied ? "connected" : "disconnected")
    }
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
  
  deinit {
      monitor?.cancel()
  }
}
