import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/song.dart';
import 'package:vii_music/responsive/songlisten_api.dart';
import 'package:vii_music/responsive/user_api.dart';
import 'package:vii_music/screen/home/component/playlist/component/lyric.dart';

import 'component/image_music.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key, required this.songs, required this.song})
      : super(key: key);
  final List<Song> songs;
  final Song song;
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int pageSelected = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration timeEnd = Duration.zero;
  Duration position = Duration.zero;

  bool isPlaying = false;
  int songIndex = 0;
  bool isLike = false;
  String idUser = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.songs.isNotEmpty) {
      for (int i = 0; i < widget.songs.length; i++) {
        if (widget.song == widget.songs[i]) {
          audioPlayer.play(widget.song.urlSong!);
          setState(() {
            songIndex = i;
          });
        }
      }

      audioPlayer.onPlayerCompletion.listen((event) {
        if (songIndex == widget.songs.length - 1) {
          audioPlayer.play(widget.songs[0].urlSong!);
          setState(() {
            songIndex = 0;
          });
        } else {
          audioPlayer.play(widget.songs[songIndex + 1].urlSong!);
          setState(() {
            songIndex = songIndex + 1;
          });
        }
      });
    } else {
      audioPlayer.play(widget.song.urlSong!);
      audioPlayer.onPlayerCompletion.listen((event) {
        audioPlayer.stop();
        likeSong();
      });
    }
    audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.PLAYING;
      //  print(isPlaying);
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        timeEnd = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    songisLike();
  }

  songisLike() {
    SharedPreferences.getInstance().then((value) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(value.getString("tokenSession")!);
      setState(() {
        idUser = decodedToken["id"];
      });

      if (widget.songs.isNotEmpty) {
        UserApi.songisLike(widget.songs[songIndex].sId!, idUser).then((value) {
          if (value) {
            setState(() {
              isLike = !isLike;
            });
          }
        });
      } else {
        UserApi.songisLike(widget.song.sId!, idUser).then((value) {
          if (value) {
            setState(() {
              isLike = !isLike;
            });
          }
        });
      }
    });
  }

  nextSong() {
    if (songIndex == widget.songs.length - 1) {
      audioPlayer.stop();
      audioPlayer.play(widget.songs[0].urlSong!);
      setState(() {
        songIndex = 0;
      });
    } else {
      audioPlayer.stop();
      audioPlayer.play(widget.songs[songIndex + 1].urlSong!);
      setState(() {
        songIndex = songIndex + 1;
      });
    }
  }

  previousSong() {
    if (songIndex == 0) {
      audioPlayer.stop();
      audioPlayer.play(widget.songs[widget.songs.length - 1].urlSong!);
      setState(() {
        songIndex = widget.songs.length - 1;
      });
    } else {
      audioPlayer.stop();
      audioPlayer.play(widget.songs[songIndex - 1].urlSong!);
      setState(() {
        songIndex = songIndex - 1;
      });
    }
  }

  likeSong() {
    SharedPreferences.getInstance().then((value) {
      if (widget.songs.isNotEmpty) {
        UserApi.likeSong(widget.songs[songIndex].sId!, idUser).then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "Like thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          } else {
            Fluttertoast.showToast(
                msg: "Like không thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          }
        });
      } else {
        UserApi.likeSong(widget.song.sId!, idUser).then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "Like thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          } else {
            Fluttertoast.showToast(
                msg: "Like không thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          }
        });
      }
    });
  }

  dislikeSong() {
    SharedPreferences.getInstance().then((value) {
      if (widget.songs.isNotEmpty) {
        UserApi.dislikeSong(widget.songs[songIndex].sId!, idUser).then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "Dislike thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          } else {
            Fluttertoast.showToast(
                msg: "Dislike không thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          }
        });
      } else {
        UserApi.dislikeSong(widget.song.sId!, idUser).then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "Dislike thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          } else {
            Fluttertoast.showToast(
                msg: "Dislike không thành công",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade300,
                textColor: Colors.black,
                fontSize: 12);
          }
        });
      }
    });
  }

  saveSongListening() async {
    if (widget.songs.isNotEmpty) {
      await ListenSongApi.saveSongListen(widget.songs[songIndex].sId!, idUser,
          position.toString(), timeEnd.toString());
    } else {
      await ListenSongApi.saveSongListen(
          widget.song.sId!, idUser, position.toString(), timeEnd.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();

    saveSongListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white.withOpacity(0.8),
                      )),
                  const Spacer(
                    flex: 2,
                  ),
                  const Text(
                    "Playing now",
                    style: TextStyle(
                        fontFamily: 'Inter', fontSize: 16, color: Colors.white),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    pageSelected = value;
                  });
                },
                children: [
                  ImagePage(
                    thumnail: widget.songs.isNotEmpty
                        ? widget.songs[songIndex].thumbnail!
                        : widget.song.thumbnail!,
                  ),
                  const LyricPage(),
                ],
              )),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 12,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 12,
                        width: 12,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: pageSelected == index
                                ? Colors.white
                                : kgrayLight.withOpacity(0.5),
                            shape: BoxShape.circle),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.songs.isNotEmpty
                            ? widget.songs[songIndex].name!
                            : widget.song.name!,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.songs.isNotEmpty
                            ? widget.songs[songIndex].singer!.name!
                            : widget.song.singer!.name!,
                        style: const TextStyle(
                            fontFamily: 'Inter-Rahular',
                            color: Colors.white,
                            fontSize: 16),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (!isLike) {
                        likeSong();
                        setState(() {
                          isLike = !isLike;
                        });
                      } else {
                        dislikeSong();
                        setState(() {
                          isLike = !isLike;
                        });
                      }
                    },
                    child: Image.asset(
                      "assets/images/like.png",
                      color: isLike ? Colors.cyan : Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              slider(context),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    fomartTime(position),
                    style: const TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  Text(
                    fomartTime(timeEnd),
                    style: const TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12,
                        color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  IconButton(
                      onPressed: () {
                        previousSong();
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 30,
                        color: Colors.white,
                      )),
                  const Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      if (isPlaying) {
                        audioPlayer.pause();

                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      } else {
                        audioPlayer.resume();
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.cyan, shape: BoxShape.circle),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  IconButton(
                      onPressed: () {
                        nextSong();
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 30,
                      )),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget slider(BuildContext context) {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            overlayShape: SliderComponentShape.noOverlay,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
        child: Slider(
            value: position.inSeconds.toDouble(),
            activeColor: Colors.cyan,
            inactiveColor: Colors.white.withOpacity(0.8),
            max: timeEnd.inSeconds.toDouble() + 1,
            min: -1,
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);
              await audioPlayer.resume();
            }));
  }

  String fomartTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
