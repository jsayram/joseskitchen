import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(JosesKitchenApp());
}

class JosesKitchenApp extends StatefulWidget {
  const JosesKitchenApp({Key? key}) : super(key: key);

  @override
  _JosesKitchenAppState createState() => _JosesKitchenAppState();
}

class _JosesKitchenAppState extends State<JosesKitchenApp> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference recipesCollection = FirebaseFirestore.instance.collection('recipes');
    CollectionReference categoryCollection = FirebaseFirestore.instance.collection('categories');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController,
          ),
        ),

        body: Center(
          child: StreamBuilder(
              stream: recipesCollection.snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                }

                return ListView(
                  children: snapshot.data!.docs.map((recipieItem){
                    return Center(
                      child: ListTile(
                        title: Text(recipieItem.get(FieldPath(['name']))),
                        onLongPress: () {
                          recipieItem.reference.delete();
                        },
                      ),
                    );
                  }).toList(),
                );


              }),
        ),



        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            recipesCollection.add({
              'name': textController.text,
            });
            textController.clear();
          },
        ),

      ),
    );
  }
}

