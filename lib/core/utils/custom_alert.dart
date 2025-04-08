import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/key.dart';

class CustomAlert {
  static final List<OverlayEntry> _activeAlerts = [];
  static final List<String> _messages = [];

  static void show({required String message, Color backgroundColor = Colors.redAccent, Duration duration = const Duration(seconds: 4)}) {
    final overlay = KeyConstant.navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    late OverlayEntry overlayEntry;
    Timer? autoRemoveTimer;

    int position = _messages.length; // Determine position based on active alerts

    overlayEntry = OverlayEntry(
      builder: (context) {
        return CustomAlertWidget(
          message: message,
          backgroundColor: backgroundColor,
          onClose: () {
            autoRemoveTimer?.cancel();
            _removeAlert(overlayEntry, message);
          },
          position: position, // Pass the position dynamically
        );
      },
    );

    _activeAlerts.add(overlayEntry);
    _messages.add(message);
    overlay.insert(overlayEntry);

    autoRemoveTimer = Timer(duration, () {
      _removeAlert(overlayEntry, message);
    });
  }

  static void _removeAlert(OverlayEntry entry, String message) {
    if (_activeAlerts.contains(entry)) {
      entry.remove();
      int index = _activeAlerts.indexOf(entry);
      _activeAlerts.removeAt(index);
      _messages.removeAt(index);

      // Reposition remaining alerts
      for (var alert in _activeAlerts) {
        alert.markNeedsBuild();
      }
    }
  }
}

class CustomAlertWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final VoidCallback onClose;
  final int position;

  const CustomAlertWidget({super.key, required this.message, required this.backgroundColor, required this.onClose, required this.position});

  @override
  CustomAlertWidgetState createState() => CustomAlertWidgetState();
}

class CustomAlertWidgetState extends State<CustomAlertWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40 + (widget.position * 60),
      right: 10,
      left: 10,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text(widget.message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                const SizedBox(width: 10),
                GestureDetector(onTap: widget.onClose, child: const Icon(Icons.close, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
