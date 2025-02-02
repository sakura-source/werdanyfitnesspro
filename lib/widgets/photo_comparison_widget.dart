import 'package:flutter/material.dart';

class PhotoComparisonWidget extends StatelessWidget {
  final String beforePhoto;
  final String afterPhoto;

  const PhotoComparisonWidget({
    super.key,
    required this.beforePhoto,
    required this.afterPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text('Before'),
            Image.network(beforePhoto),
          ],
        ),
        Column(
          children: [
            const Text('After'),
            Image.network(afterPhoto),
          ],
        ),
      ],
    );
  }
}
