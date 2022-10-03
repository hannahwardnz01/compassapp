import 'package:flutter/material.dart';
import '../screens/home.dart';

void main() {
  runApp(const Compass());
}

class Compass extends StatelessWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
