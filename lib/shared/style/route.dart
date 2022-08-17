import 'package:flutter/material.dart';

class Routes extends PageRouteBuilder
{
  final page;
  Routes(this.page):super(
      pageBuilder: (context,animation,animationTwo)=>page,
      transitionsBuilder:(context,animation,animationTwo,child)
      {
        var begin=Offset(-1.0, 0.0);
        var end=Offset(0, 0);
        var tween=Tween(begin: begin,end: end);
        var offSetAnimation=animation.drive(tween);
        return SlideTransition(position: offSetAnimation,child: child,);
      }
  );
}