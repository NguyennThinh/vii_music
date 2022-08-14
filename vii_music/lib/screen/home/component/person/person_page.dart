import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';
import 'package:vii_music/model/user.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({Key? key, required this.users}) : super(key: key);
  final Users users;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                users.avatar!,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${users.name}",
              style: const TextStyle(
                  fontFamily: 'Inter', fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "  Personal Information",
            style: TextStyle(
                fontFamily: 'Inter-Regular', fontSize: 18, color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 15,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 15,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Language",
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 15,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "About",
                  style: TextStyle(
                      fontFamily: 'Inter-Regular',
                      fontSize: 18,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Privacy",
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 15,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Storage",
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 15,
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Audio Quality",
                  style: TextStyle(
                      fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
