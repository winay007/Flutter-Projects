import 'package:flutter/material.dart';
import 'package:instagram_ui/util/bubble_stories.dart';
import 'package:instagram_ui/util/user_post.dart';

class Home extends StatelessWidget {
  final List<String> people = [
    "Winay",
    "Eren",
    "Levi",
    "kasmaru",
    "Mikasas",
    "Mikasas"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Instagram'),
              Row(
                children: [
                  Icon(Icons.add),
                  Padding(
                      padding: EdgeInsets.all(15), child: Icon(Icons.favorite)),
                  Icon(Icons.share),
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            //Stories
            Container(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      return BubbleStories(people[index]);
                    })),
           //posts
            Expanded(
              child: ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: UserPost(people[index]));
                  }),
            )
          ],
        ));
  }
}
