import 'package:flutter/material.dart';

class ZoomInOut extends StatelessWidget {
  const ZoomInOut({
    super.key,
    required this.getLocation,
    required this.zoomIn,
    required this.zoomOut,
  });

  final Function() getLocation;
  final Function() zoomIn;
  final Function() zoomOut;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: Colors.black45,
              mini: true,
              onPressed: getLocation,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
            const SizedBox(height: 3),
            FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: Colors.black45,
              mini: true,
              onPressed: zoomIn,
              child: const Icon(Icons.remove, color: Colors.white),
            ),
            const SizedBox(height: 3),
            FloatingActionButton(
              heroTag: "btn3",
              backgroundColor: Colors.black45,
              mini: true,
              onPressed: zoomOut,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
