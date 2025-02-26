import 'package:flutter/material.dart';

class AnimatedTweeenBuilder extends StatelessWidget {
  const AnimatedTweeenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tween Builder",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 200),
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeInCirc,
        builder: (context, size, widget) {
          return Center(
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: size,
                    spreadRadius: size / 2,
                  ),
                ],
              ),
              child: widget,
            ),
          );
        },
        child: Icon(Icons.call, color: Colors.white, size: 30),
      ),
    );
  }
}
