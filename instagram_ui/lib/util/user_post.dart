import 'package:flutter/material.dart';

class UserPost extends StatelessWidget {
  final String name;

  UserPost(@required this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //posted by
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          ),
        ),
        //Post
        Container(
          width: double.infinity,
          height: 350,
          color: Colors.grey[300],
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () {},
              ),
            ],
          ),
        ),
        //Liked by Text
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text('Liked by'),
              Text(' WInay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Text(' and'),
              Text(' others',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        //Caption
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
            TextSpan(
                text: name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ' afvukiafvkiauvf afibaoifba oifgaofafbaf foagfoaofbaoifbia'),
          ])),
        )
      ],
    );
  }
}
