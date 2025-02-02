import 'package:flutter/material.dart';

class PhotoComparisonWidget extends StatelessWidget {
  final String beforePhoto;
  final String afterPhoto;

  const PhotoComparisonWidget({super.key, 
    required this.beforePhoto,
    required this.afterPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Before'),
        Image.network(beforePhoto),
        const SizedBox(height: 16),
        const Text('After'),
        Image.network(afterPhoto),
      ],
    );
  }
}
