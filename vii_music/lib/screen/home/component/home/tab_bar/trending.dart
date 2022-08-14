import 'package:flutter/material.dart';
import 'package:vii_music/model/song.dart';

import '../../../../../contants.dart';

class Trending extends StatelessWidget {
  const Trending({Key? key, required this.trendSong}) : super(key: key);
  final List<Song> trendSong;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendSong.length > 2 ? 2 : trendSong.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  height: 170,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "${trendSong[index].thumbnail}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 170,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                puple.withOpacity(0.8),
                                Colors.white.withOpacity(0.05)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${trendSong[index].name}",
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            Text(
                              "${trendSong[index].singer!.name}",
                              style: const TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontSize: 12,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 20,
                          bottom: 20,
                          child: Image.asset("assets/images/play.png"))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
