import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Cow Milking",
      theme: ThemeData(
        primaryColor: clrApp,
        fontFamily: "MedulaOne",
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/Bluetooth': (context) => Bluetooth(),
        '/Assignment': (context) => Assignment(),
      },
    ),
  );
}

final String imgMilkAmount = "assets/images/amount_milk.png";
final String imgCowId = "assets/images/id_cow2.png";
final String imgMilkTemp = "assets/images/temperature_milk.png";
final String appName = "Yıldız Süt Ölçer";
final Color clrApp = Color(0xFF1A258F);
final Color clrBarText = Color(0xFFA0FF00);
final Color clrBackground = Color(0xFFFFFFFF);
final Color clrText = Color(0xFF860E68);
final Color clrSubText = Color(0xFFFFFFFF);
final Color clrMilkAmount = Color(0xFF3EAD5E);
final Color clrCowId = Color(0xFFFF8E01);
final Color clrMilkTemp = Color(0xFFD21E4B);

var cow1 = Cow(
  cowId: 003,
  milkAmount: 18.370,
  milkTemp: 15,
);

var cow2 = Cow(
  cowId: 019,
  milkAmount: 17.260,
  milkTemp: 14,
);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    connect();
    return Scaffold(
      backgroundColor: clrBackground,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.bluetooth,
              color: clrSubText,
            ),
            onPressed: () => Navigator.pushNamed(context, '/Bluetooth'),
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.assignment,
                color: clrSubText,
              ),
              onPressed: () => Navigator.pushNamed(context, '/Assignment'),
            ),
          ),
        ],
        title: Center(
          child: AutoSizeText(
            "Yıldız Süt Ölçer",
            style: TextStyle(
              fontFamily: "LobsterTwo",
              fontSize: 50,
              color: clrBarText,
            ),
            maxLines: 1,
          ),
        ),
      ),
      body: mainPage(),
    );
  }
}

Column mainPage() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      unite("Birinci Ünite", cow1.milkAmount, cow1.cowId, cow1.milkTemp),
      unite("İkinci Ünite", cow2.milkAmount, cow2.cowId, cow2.milkTemp),
    ],
  );
}

Column unite(String unite, double _amount, int _id, int temperature) {
  return Column(
    children: [
      Container(
        color: clrApp,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              unite,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: clrSubText,
                fontSize: 20,
                fontFamily: "Noticia Text",
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      rowAmount(_amount),
      Row(
        children: <Widget>[
          Expanded(
            child: rowId(imgCowId, _id, clrCowId),
          ),
          Expanded(
            child: rowTemp(imgMilkTemp, temperature, clrMilkTemp),
          ),
        ],
      ),
    ],
  );
}

Widget rowAmount(double amount) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 3, color: clrText),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Image.asset(
            imgMilkAmount,
            color: clrMilkAmount,
          ),
        ),
        Expanded(
          flex: 3,
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: amount.toString().substring(0, 2),
                  style: TextStyle(
                    color: clrText,
                    fontSize: 135,
                    fontFamily: "MedulaOne",
                  ),
                ),
                TextSpan(
                  text:
                      amount.toString().substring(2, amount.toString().length) +
                          " Lt",
                  style: TextStyle(
                    color: clrText,
                    fontSize: 95,
                    fontFamily: "MedulaOne",
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget rowId(String image, int text, Color color) {
  return Container(
    padding: EdgeInsets.only(top: 3),
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(width: 3, color: clrText),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Image.asset(
            image,
            color: color,
          ),
        ),
        Expanded(
          child: Text(
            text.toString(),
            style: TextStyle(
              color: clrText,
              fontSize: 75,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget rowTemp(String image, int text, Color color) {
  return Container(
    padding: EdgeInsets.only(top: 3),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            text.toString(),
            style: TextStyle(
              color: clrText,
              fontSize: 75,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Image.asset(
            image,
            color: color,
          ),
        ),
      ],
    ),
  );
}

class Bluetooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrBackground,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: clrSubText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: clrSubText,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
        title: Center(
          child: AutoSizeText(
            "Bluetooth",
            style: TextStyle(
              fontFamily: "LobsterTwo",
              fontSize: 50,
              color: clrBarText,
            ),
            maxLines: 1,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Bluetooth",
          style: TextStyle(
            fontSize: 50,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class Assignment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrBackground,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: clrSubText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: clrSubText,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
        title: Center(
          child: AutoSizeText(
            "Database",
            style: TextStyle(
              fontFamily: "LobsterTwo",
              fontSize: 50,
              color: clrBarText,
            ),
            maxLines: 1,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Database",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

class Cow {
  final int cowId;
  final double milkAmount;
  final int milkTemp;

  Cow({this.cowId, this.milkAmount, this.milkTemp});

  Map<String, dynamic> toMap() {
    return {'id': cowId, 'amount': milkAmount, 'temp': milkTemp};
  }

  @override
  String toString() {
    return 'Cow{id: $cowId, name: $milkAmount, age: $milkTemp}';
  }
}

void connect() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'cows_database.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE cows(id INTEGER PRIMARY KEY, amount REAL, temp INTEGER, times INTEGER, date NUMERIC)");
    },
    version: 1,
  );

  Future<void> insertCow(Cow cow) async {
    final Database db = await database;
    await db.insert(
      'cows',
      cow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cow>> cows() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cows');

    return List.generate(maps.length, (i) {
      return Cow(
        cowId: maps[i]['id'],
        milkAmount: maps[i]['amount'],
        milkTemp: maps[i]['temp'],
      );
    });
  }

  Future<void> updateCow(Cow cow) async {
    final db = await database;

    await db.update(
      'cows',
      cow.toMap(),
      where: "id = ?",
      whereArgs: [cow.cowId],
    );
  }

  Future<void> deleteCow(int id) async {
    final db = await database;

    await db.delete(
      'cows',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
