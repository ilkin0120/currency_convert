import 'package:flutter/material.dart';

abstract class DefaultSnackBarBase {
  static const snackBarDuration = Duration(seconds: 1);
}

class DefaultSnackBar implements DefaultSnackBarBase {
  void errorSnackBar(BuildContext context, String text) {
    _snackBarWrapper(
        context,
        Row(
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        ));
  }

  void _snackBarWrapper(BuildContext context, Widget child) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      content: child,
      duration: DefaultSnackBarBase.snackBarDuration,
    ));
  }
}
