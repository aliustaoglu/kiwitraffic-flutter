import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBar = AppBar(
  title: Header(),
  automaticallyImplyLeading: false,
);

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Kiwi Traffic'),
          Text(
            "New Zealand's Traffic Updates",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
