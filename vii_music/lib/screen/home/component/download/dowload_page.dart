import 'package:flutter/material.dart';
import 'package:vii_music/contants.dart';

class DowloadPage extends StatelessWidget {
  const DowloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                "Downloads",
                style: TextStyle(
                    fontFamily: 'Inter', color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://gentlenobra.com/wp-content/uploads/2021/11/anh-gai-xinh-trang-non-na.jpg",
                            height: 75,
                            width: 76,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Live Long",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet",
                              style: TextStyle(
                                  fontFamily: 'Inter-Regular',
                                  color: Colors.white,
                                  fontSize: 14),
                            )
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert,
                                size: 30, color: Colors.white))
                      ],
                    ),
                  );
                },
              ))
            ],
          ),
        ));
  }
}
