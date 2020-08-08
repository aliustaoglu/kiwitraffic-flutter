import 'package:flutter/material.dart';

var _textSyle = TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontWeight: FontWeight.bold
);

class ActionButton extends StatelessWidget {
  String img;
  String txt;
  var onTap;
  
  ActionButton(this.img, this.txt, this.onTap);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.width/2,
        width: MediaQuery.of(context).size.width/2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(img),
                )),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text(txt, style: _textSyle,)
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
