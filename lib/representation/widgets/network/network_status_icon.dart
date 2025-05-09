import 'package:flutter/material.dart';

enum NetworkStatus { connected, disconnected }

class NetworkStatusIcon extends StatelessWidget {
  final NetworkStatus status;

  const NetworkStatusIcon({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case NetworkStatus.connected:
        return const Icon(Icons.signal_wifi_4_bar, color: Colors.green);
      case NetworkStatus.disconnected:
        return const Icon(Icons.signal_wifi_off, color: Colors.red);
    }
  }
}
