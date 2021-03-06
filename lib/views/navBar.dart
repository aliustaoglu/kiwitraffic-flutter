import 'package:flutter/material.dart';

var _textStyle = TextStyle(
  color: Colors.amber
);

Widget navBar(Function callback){
  return BottomNavigationBar(
    backgroundColor: Color.fromARGB(255, 41, 47, 71),
    onTap: (int selectedIndex){
      callback(selectedIndex);
    }
    ,
    currentIndex: 0,
    items: [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.amber,
          ),
          activeIcon: Icon(
            Icons.home,
            color: Colors.orange,
          ),
          title: Text('Home', style: _textStyle,)
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.info_outline,
          color: Colors.amber,
        ),
        title: Text('About', style: _textStyle,),
      )
    ],
  );
}