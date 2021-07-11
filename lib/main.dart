import 'package:flutter/material.dart';

void main(){

  runApp(FireStoreApp());
}


class FireStoreApp extends StatefulWidget {
  const FireStoreApp({Key? key}) : super(key: key);

  @override
  _FireStoreAppState createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<FireStoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exmaple Firestore build')
        )
      )
    );
  }
}

