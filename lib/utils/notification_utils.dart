import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationUtils {
  // Show a custom Toast
  static void showToast({
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required Icon icon,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
      webBgColor: backgroundColor.toString(),
      webPosition: "center",
      timeInSecForIosWeb: 1,
    );
  }

  // Show a custom Flushbar
  static void showFlushbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required Icon icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: icon,
      backgroundColor: backgroundColor,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
      flushbarPosition: FlushbarPosition.TOP,
      duration: duration,
      barBlur: 20,
      messageColor: textColor,
      padding: EdgeInsets.all(16),
    ).show(context);
  }
}
