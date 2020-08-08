import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  String img;
  
  ActionButton(this.img);
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(img),
              )),
        ),
      ),
    );
  }
}
