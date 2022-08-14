import 'package:flutter/material.dart';

import '../../../../contants.dart';
import '../../../search/search_screen.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: 40,
          child: Row(
            children: const [
              Icon(
                Icons.search,
                color: kgray,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Search",
                style: TextStyle(color: kgray, fontSize: 16),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.mic,
                color: kgray,
              ),
            ],
          )),
    );
  }
}
