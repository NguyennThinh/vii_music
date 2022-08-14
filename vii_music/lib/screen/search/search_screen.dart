import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/song.dart';
import 'package:vii_music/responsive/song_api.dart';
import 'package:vii_music/screen/home/component/playlist/play_music_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Song> listSong = [];
  List<Song> listSongChange = [];
  bool isSearch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SongApi.getSong().then((value) {
      setState(() {
        listSong = value;
        listSongChange = List.from(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 45,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      listSongChange = listSong
                          .where((element) => element.name!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  style: const TextStyle(
                      color: kgray, fontSize: 17, fontFamily: 'Inter-Regular'),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      suffixIcon: const Icon(Icons.mic),
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: const TextStyle(color: kgray),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: listSongChange.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayPage(
                                  songs: [], song: listSongChange[index]),
                            ));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              listSongChange[index].thumbnail!,
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listSongChange[index].name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Inter'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                listSongChange[index].singer!.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Inter-Regular'),
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      )),
                );
              },
            )),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
