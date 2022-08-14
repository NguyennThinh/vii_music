import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/song.dart';
import 'package:vii_music/model/user.dart';
import 'package:vii_music/responsive/user_api.dart';
import 'package:vii_music/screen/home/component/download/dowload_page.dart';

import 'package:vii_music/screen/home/component/like/like_page.dart';
import 'package:vii_music/screen/home/component/person/person_page.dart';
import 'package:vii_music/screen/home/component/playlist/play_music_page.dart';

import 'component/home/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int selectIndex = 0;
  int tabSelect = 0;
  String jwt = "";
  Users users = Users();
  List<Song> listSongLike = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        users =
            Users.fromJson(JwtDecoder.decode(value.getString("tokenSession")!));
      });
    });

    UserApi.getSongbyUser().then((value) {
      setState(() {
        listSongLike = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    final screens = [
      HomePage(tabController: tabController),
      LikePage(listSongs: listSongLike, user: users),
      const DowloadPage(),
      PersonPage(
        users: users,
      )
    ];

    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: Row(
        children: [
          navigationItem(Icons.home_filled, 0, true),
          navigationItem(Icons.heart_broken, 1, false),
          //  navigationItem(Icons.play_circle_outline, 2, true),
          navigationItem(Icons.file_download_outlined, 2, true),
          navigationItem(Icons.person_outline, 3, true),
        ],
      ),
      body: SafeArea(
        child: screens[selectIndex],
      ),
    );
  }

  Widget navigationItem(IconData icon, int index, bool isIcon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: selectIndex == index
            ? const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [background, navbar]),
                color: navbar,
                border:
                    Border(bottom: BorderSide(color: Colors.cyan, width: 2)))
            : const BoxDecoration(
                color: navbar,
              ),
        child: isIcon
            ? Icon(
                icon,
                color: selectIndex == index ? Colors.cyan : Colors.white,
              )
            : Image.asset(
                "assets/images/like.png",
                color: selectIndex == index ? Colors.cyan : Colors.white,
              ),
      ),
    );
  }

  Widget getWidget(Widget screen) {
    return screen;
  }
}
