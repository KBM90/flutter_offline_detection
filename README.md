# Flutter Offline Detection

A production-ready Flutter package to detect **REAL internet connectivity** using native APIs (`ConnectivityManager.NetworkCallback` on Android, `NWPathMonitor` on iOS).

Unlike other packages that only check for "network connection" (e.g. Wi-Fi connected but no internet), this package verifies **actual internet reachability**.

## Features

- 🚀 **Real Internet Detection**: Validates if the network actually has internet access.
- ⚡ **Native Implementation**: Uses `NetworkCallback` (Android) and `NWPathMonitor` (iOS).
- 🔋 **Battery Efficient**: No polling. Event-based updates only when status changes.
- 🛡️ **Platform Support**: Android 21+, iOS 12+.

## Why detection is better than `connectivity_plus`?

| Feature | `connectivity_plus` | `flutter_offline_detection` |
|---------|---------------------|-----------------------------|
| Checks Wi-Fi connection | ✅ | ✅ |
| Checks Mobile Data connection | ✅ | ✅ |
| **Verifies Internet Access** | ❌ (Often returns "connected" on captive portals or broken ISPs) | ✅ (Checks `NET_CAPABILITY_VALIDATED` / `.satisfied`) |
| **Instant Updates** | ✅ | ✅ |

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_offline_detection:
    path: . # If local, otherwise usage from pub.dev
```

## Usage

```dart
import 'package:flutter_offline_detection/flutter_offline_detection.dart';

// Check once
final status = await FlutterOfflineDetection.checkNow();
if (status == InternetStatus.connected) {
  print("We have internet!");
}

// Listen for changes
FlutterOfflineDetection.onStatusChange.listen((status) {
  print("Status changed to: $status");
});
```

## Platform Configuration

### Android

Works out of the box for Android 5.0 (API 21) +.
Internally uses `ConnectivityManager.registerNetworkCallback` and checks for `NET_CAPABILITY_VALIDATED` (on Android M+) to ensure the connection is valid.

**Permissions**:
The plugin adds `ACCESS_NETWORK_STATE` automatically.

### iOS

Works out of the box for iOS 12+.
Internally uses `NWPathMonitor` to check if the path status is `.satisfied`.

## License

MIT

## ☕ Support

If this project helped you, consider buying me a coffee ☕

💼 **OKX Wallet**
- USDT (TRC20): `TCFDcTTbSKp5WRaMj4jGkJRNgrSzAr33ra`
- USDC (ERC20): `0x779faf0ed2a549d70e1053ea83d2d991d5f5edcf`
- BTC (BTC) :   `37C6azvFCgECTvFfEChuZeLw8UNUoUjwd1`

