import 'package:flutter/material.dart';
import 'package:kiwitraffic/components/ImageButton.dart';

TextStyle txtStyle = TextStyle(
  color: Colors.white
);

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/images/about.jpg'),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("This is an open source, non-profit project made with Flutter. It's free and does not contain any ads. You can send your ideas, bug reports or even pull requests using the repository.", style: txtStyle,),
                SizedBox(height: 10,),
                Text("This application uses NZTA InfoConnect public API for traffic, roadworks, closures, area warnings and cameras.", style: txtStyle,),
                SizedBox(height: 10,),
                Text("Developed by Cüneyt Aliustaoğlu", style: txtStyle,),
                SizedBox(height: 10,),
                Text("I am a full stack developer based in Auckland. If you want to work with me, connect me using the links below.", style: txtStyle),
                SizedBox(height: 10),
                Row(
                  children: [
                    ImageButton('home', 'https://cuneyt.aliustaoglu.biz/en'),
                    ImageButton('github', 'https://github.com/aliustaoglu'),
                    ImageButton('linkedin', 'https://www.linkedin.com/in/aliustaoğlu'),
                    ImageButton('youtube', 'https://www.youtube.com/user/hoshmack'),
                  ],
                ),
                SizedBox(height: 10),
                TextButton('About Photo by Stas Kulesh on Unsplash', 'https://unsplash.com/@kulesh'),
                TextButton('Auckland Photo by Samuel Ferrara on Unsplash', 'https://unsplash.com/@samferrara'),
                TextButton('Highway Photo by Jean-Pierre Brungs on Unsplash', 'https://unsplash.com/@johnnyabroad'),

              ],
            ),
          )
        ],
      ),
    );
  }
}
