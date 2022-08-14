import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/song.dart';
import 'package:vii_music/screen/home/component/playlist/play_music_page.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({Key? key, required this.newSong}) : super(key: key);
  final List<Song> newSong;
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
              itemCount: newSong.length > 2 ? 2 : newSong.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayPage(songs: newSong, song: newSong[index]),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    height: 170,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "${newSong[index].thumbnail}",
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
                                "${newSong[index].name}",
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                              Text(
                                "${newSong[index].singer!.name}",
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
