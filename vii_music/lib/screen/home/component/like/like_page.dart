import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/song.dart';
import 'package:vii_music/model/user.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key, required this.listSongs, required this.user})
      : super(key: key);
  final List<Song> listSongs;
  final Users user;
  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  bool isPlay = false;
  int selectIndex = -1;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
  }

  playMusic(String url) {
    audioPlayer.play(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: kgray.withOpacity(0.8), shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/images/like.png",
                    color: Colors.cyan,
                  ),
                ),
                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage("${widget.user.avatar}"),
                ),
                Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: kgray.withOpacity(0.8), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: Colors.white,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: widget.listSongs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (selectIndex != index) {
                      playMusic(widget.listSongs[index].urlSong!);
                      setState(() {
                        selectIndex = index;
                        isPlay = true;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: selectIndex == index
                            ? kgray.withOpacity(0.8)
                            : null,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.listSongs[index].name}",
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.cyan,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${widget.listSongs[index].singer!.name}",
                              style: const TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  color: Colors.white,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              if (isPlay) {
                                audioPlayer.pause();
                                setState(() {
                                  isPlay = !isPlay;
                                });
                              } else {
                                audioPlayer.resume();
                                setState(() {
                                  isPlay = !isPlay;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectIndex == index
                                      ? Colors.cyan
                                      : kgray.withOpacity(0.8)),
                              child: Icon(
                                isPlay ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
