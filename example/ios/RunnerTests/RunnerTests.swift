import Flutter
import UIKit
import XCTest


@testable import flutter_offline_detection

// This demonstrates a simple unit test of the Swift portion of this plugin's implementation.
//
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.

class RunnerTests: XCTestCase {

  func testCheckNow() {
    let plugin = FlutterOfflineDetectionPlugin()

    let call = FlutterMethodCall(methodName: "checkNow", arguments: [])

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      let status = result as? String
      XCTAssertTrue(status == "connected" || status == "disconnected")
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}
