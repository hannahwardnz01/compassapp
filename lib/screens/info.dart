import 'package:flutter/material.dart';

class InfoLayout extends StatefulWidget {
  const InfoLayout({Key? key}) : super(key: key);

  @override
  State<InfoLayout> createState() => _InfoLayoutState();
}

class _InfoLayoutState extends State<InfoLayout> {
  @override
  Widget build (BuildContext ctxt) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "How to use Compass App", 
          style: TextStyle(
            color: Colors.white,),
            ),
      ),
      body: 
      Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "How to use:",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          Text(
            "When you're on the home screen, point the front of your phone towards an object. The given angle will tell you your angle to north.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            "For example, when the angle displayed is 0, you are pointing your phone north.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            "Angle infomation: ",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          Text(
            "0 = North, 45 = North East, 90 = East, 135 = South East, 180 = South, 225 = South West, 270 = West, 315 = North West",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ]
      )
      )
    );
  }
}