import 'package:flutter/material.dart';

class Leading extends StatelessWidget {
  const Leading({super.key, required this.function});

  final Function() function;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: function,
      icon: const Icon(Icons.arrow_back),
    );
  }
}
