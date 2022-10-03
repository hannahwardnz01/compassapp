import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'bearings.dart';
import 'info.dart';
import '../database_helper.dart';
import 'package:intl/intl.dart';



class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

final dbHelper = DatabaseHelper.instance;


class _HomeLayoutState extends State<HomeLayout> {
  double? heading = 0;
  @override
  void initState() {
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading!;
      });
    });
    super.initState();
  }

  // done
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Compass App',
          style: TextStyle(color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${heading!.ceil()}°",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/cadrant.png'),
                Transform.rotate(
                  angle: ((heading ?? 0) * (pi / 180) * -1),
                  child: Image.asset(
                    'assets/images/compass.png',
                    scale: 1.1,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text(
                  'How to use Compass App',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoLayout()),
                );},
              ),
             TextButton(
                child: const Text(
                  'View saved bearings',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BearingsLayout()),
                );
                }
              ),
              TextButton(
                child: const Text(
                  'Save this bearing', 
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  delete();
                  insert(heading!);
                  },
                
            ),
            ],
      ),
      ]
      )
    );
  }
}

void insert(bearing) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnBearing : bearing,
      DatabaseHelper.columnDateTime  : DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void query() async {
    print('query all rows:');
    final allRows = await dbHelper.queryAllRows();

    allRows.forEach(print);
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    print("run1");
    final rowsDeleted = await dbHelper.delete();
    print('deleted all rows');
  }
