import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageButton extends StatelessWidget {
  String icon;
  String url;

  ImageButton(this.icon, this.url);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image(
        image: AssetImage('assets/icons/${icon}.png'),
        height: 32,
      ),
      onTap: () {
        launch(url);
      },
    );
  }
}

class TextButton extends StatelessWidget {
  String text;
  String url;

  TextButton(this.text, this.url);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        launch(url);
      },
    );
  }
}
