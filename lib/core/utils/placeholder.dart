import 'package:flutter/material.dart';

class ImgPlaceHolder extends StatelessWidget {

  const ImgPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return  const CircularProgressIndicator(strokeWidth: 3);
  }
}
