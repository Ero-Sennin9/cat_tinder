import 'package:flutter/material.dart';

enum Verdict { like, dislike }

class _Settings {
  final MaterialColor color;
  final IconData icon;

  const _Settings({required this.color, required this.icon});
}

class VerdictButton extends StatelessWidget {
  static const double _size = 70;
  final Function() callback;
  final Verdict verdict;

  const VerdictButton({
    required this.verdict,
    required this.callback,
    super.key,
  });

  _Settings _getSettings(Verdict verdict) {
    switch (verdict) {
      case Verdict.like:
        return _Settings(color: Colors.green, icon: Icons.thumb_up);
      case Verdict.dislike:
        return _Settings(color: Colors.red, icon: Icons.thumb_down);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      highlightColor: _getSettings(verdict).color,
      borderRadius: BorderRadius.circular(_size * 5 / 4),
      child: Padding(
        padding: EdgeInsets.all(_size / 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_size / 2),
          child: Container(
            width: _size,
            height: _size,
            color: _getSettings(verdict).color,
            child: Center(
              child: Icon(color: Colors.white, _getSettings(verdict).icon),
            ),
          ),
        ),
      ),
    );
  }
}
