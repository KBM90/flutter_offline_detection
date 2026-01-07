import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_offline_detection/flutter_offline_detection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = 'Unknown';
  final List<String> _logs = [];

  StreamSubscription<InternetStatus>? _subscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _subscription = FlutterOfflineDetection.onStatusChange.listen((status) {
      if (!mounted) return;
      setState(() {
        final msg = "Event: ${status.name}";
        _status = status.name;
        _logs.insert(
          0,
          "${DateTime.now().toIso8601String().split('T').last}: $msg",
        );
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    InternetStatus? status;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      status = await FlutterOfflineDetection.checkNow();
    } catch (e) {
      debugPrint("Failed to get status: $e");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (status != null) {
      setState(() {
        _status = status!.name;
        _logs.insert(0, "Initial check: ${status.name}");
      });
    }
  }

  Future<void> _checkNow() async {
    final status = await FlutterOfflineDetection.checkNow();
    setState(() {
      _logs.insert(0, "Manual check: ${status.name}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Offline Detection Example')),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: _status == 'connected'
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _status == 'connected' ? Icons.wifi : Icons.wifi_off,
                    size: 48,
                    color: _status == 'connected' ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    _status.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _checkNow,
                child: const Text("Check Now"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_logs[index]), dense: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
