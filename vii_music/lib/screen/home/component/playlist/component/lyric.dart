import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';

class LyricPage extends StatelessWidget {
  const LyricPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: lyric,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
