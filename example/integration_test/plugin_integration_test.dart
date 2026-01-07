// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_offline_detection/flutter_offline_detection.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('checkNow test', (WidgetTester tester) async {
    final InternetStatus status = await FlutterOfflineDetection.checkNow();
    // Verify that we get a valid InternetStatus result
    expect(status, isA<InternetStatus>());
  });
}
