import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
    required this.thumnail,
  }) : super(key: key);
  final String thumnail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          thumnail,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
