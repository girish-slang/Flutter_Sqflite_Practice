import 'package:flutter/material.dart';
import 'package:flutter_database_tut/database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                int i = await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnName: "Girish",
                });
              },
              child: Text('insert')),
          TextButton(
              onPressed: () async {
                List<Map<String, dynamic>> list =
                    await DatabaseHelper.instance.queryAll();
                print(list);
              },
              child: Text('query')),
          TextButton(
              onPressed: () async {
                int numOfRowsUpdated = await DatabaseHelper.instance.update({
                  DatabaseHelper.columnId: 10,
                  DatabaseHelper.columnName: "Girish",
                });
              },
              child: Text('update')),
          TextButton(
              onPressed: () async {
                int numOfRowsDeleted = await DatabaseHelper.instance.delete(1);
              },
              child: Text('delete')),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
