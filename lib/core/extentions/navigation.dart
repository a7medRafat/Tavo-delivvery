import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> go<T>({required Widget screen}) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<T?> goAndReplace<T>({required Widget screen}) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<T?> goAndRemoveAll<T>({required Widget screen}) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  bool pop() {
    Navigator.pop(this);
    return true;
  }
}
