import 'package:flutter/material.dart';
import "home.dart";

class BearingsLayout extends StatefulWidget {
  const BearingsLayout({Key? key}) : super(key: key);

  @override
  State<BearingsLayout> createState() => _BearingsLayoutState();
}

class _BearingsLayoutState extends State<BearingsLayout> {
  @override
  Widget build (BuildContext ctxt) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My saved bearings", style: TextStyle(color: Colors.white,),),
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
              getString(),
              style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          ]
        )
      );
  }
}