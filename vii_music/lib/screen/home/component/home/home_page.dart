import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vii_music/model/songlisten.dart';
import 'package:vii_music/responsive/song_api.dart';
import 'package:vii_music/responsive/songlisten_api.dart';
import 'package:vii_music/screen/home/component/playlist/play_music_page.dart';

import '../../../../contants.dart';
import '../../../../model/song.dart';
import 'search_view.dart';

import 'tab_bar/recommendation.dart';
import 'tab_bar/trending.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Song> newSong = [];
  List<Song> trendingSong = [];

  List<ListenSong> listeningSong = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SongApi.getNewSong().then((value) {
      setState(() {
        newSong = value;
      });
    });
    SongApi.getSongTrend().then((value) {
      setState(() {
        trendingSong = value;
      });
    });
    getSongListen();
  }

  getSongListen() {
    SharedPreferences.getInstance().then((value) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(value.getString("tokenSession")!);

      ListenSongApi.getSongListen(decodedToken["id"]).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            listeningSong = value;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello Vini,",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "What You want to hear today ?",
            style: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SearchView(),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TabBar(
                isScrollable: true,
                controller: widget._tabController,
                labelColor: Colors.cyan,
                labelStyle:
                    const TextStyle(fontFamily: 'Inter-Regular', fontSize: 12),
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: "Recommendation",
                  ),
                  Tab(
                    text: "Trending",
                  ),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 170,
            child: TabBarView(controller: widget._tabController, children: [
              Recommendation(newSong: newSong),
              Trending(trendSong: trendingSong),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Recently Play",
                style: TextStyle(
                    fontFamily: 'Inter', fontSize: 16, color: Colors.white),
              ),
              Text(
                "See all",
                style: TextStyle(
                    fontFamily: 'Inter-Regular',
                    fontSize: 16,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          if (listeningSong.isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount: listeningSong.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayPage(
                              songs: [], song: listeningSong[index].song!),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    height: 90,
                    decoration: BoxDecoration(
                        color: kgray.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                              listeningSong[index].song!.thumbnail!),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${listeningSong[index].song!.name}",
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            Text(
                              "${listeningSong[index].song!.singer!.name} ",
                              style: const TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${fomartTime(parseDuration(listeningSong[index].time!))}/",
                                  style: const TextStyle(
                                      fontFamily: 'Inter-Regular',
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                Text(
                                  fomartTime(parseDuration(
                                      listeningSong[index].timeEnd!)),
                                  style: const TextStyle(
                                      fontFamily: 'Inter-Regular',
                                      fontSize: 12,
                                      color: Colors.cyan),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.cyan),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          else
            Expanded(child: Container())
        ],
      ),
    );
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  String fomartTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
