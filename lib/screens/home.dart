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
String s = "";

class _HomeLayoutState extends State<HomeLayout> {
  double? heading = 0;
  
  String getHeading(){
    double? h = 360 - heading!;
    if(h == 360){h = 0;}
    String hString = "${h.toStringAsFixed(2)}°";
    return hString;
}
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
    setString();
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
            getHeading(),
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
                onPressed: () {
                  Navigator.push(
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
                  insert(getHeading());
                  setString();
                  },
                
            ),
             TextButton(
                child: const Text(
                  'Clear saved bearings', 
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  s = "";
                  delete();
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
      DatabaseHelper.columnDateTime  : DateFormat('yyyy/MM/dd - kk:mm').format(DateTime.now()),
    };
    dbHelper.insert(row);
  }

  void setString() async {
    s = "";
    Future<List> queryResults =  dbHelper.getData();
    List list = await queryResults ;
    list.forEach((element) {
      String ogdata = element.toString();
      final data = ogdata.split(",");
      String bearing = data[0].substring(10, data[0].length-1);
      print("br " + bearing);
      final dateTime = data[1].split("-");
      //.substring(6,ogdata.length-1).split("-");
      String date = dateTime[0].substring(7,dateTime[0].length-1);
      String time = dateTime[1].substring(1,dateTime[1].length-1);;
      s+= "Bearing reccorded at $time on the $date was $bearing°\n";
      });
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    dbHelper.delete();
    print('deleted all rows');
  }

  void queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach(print);
  }

String getString(){
  queryAll();
  return s;
}


