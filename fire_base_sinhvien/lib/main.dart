import 'package:fire_base/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ADD(),
    );
  }
}

class ADD extends StatefulWidget {
  @override
  State<ADD> createState() => _ADDState();
}

class _ADDState extends State<ADD> {
  // const ADD({Key? key}) : super(key: key);
  final _id = TextEditingController();
  final _ngaySinh = TextEditingController();

  final _maSinhVien = TextEditingController();

  final _gioiTinh = TextEditingController();

  final _queQuan = TextEditingController();
  var _output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 186, 248, 244),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('ID:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _id,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('M?? sinh vi??n:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _maSinhVien,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Ng??y sinh:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _ngaySinh,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Gi???i t??nh:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _gioiTinh,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    child: Text('Qu?? qu??n:'),
                  ),
                  Container(
                      width: 300,
                      child: TextField(
                        controller: _queQuan,
                      )),
                ],
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  CollectionReference collection =
                      FirebaseFirestore.instance.collection('SinhVien');
                  await collection.add({
                    "MaSinhVien": _maSinhVien.text,
                    "NgaySinh": _ngaySinh.text,
                    "GioiTinh": _gioiTinh.text,
                    "QueQuan": _queQuan.text
                  });
                },
                child: Text('T???o'),
              ),
            ),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('SinhVien');
                      collection.doc(_id.text).update({
                        "MaSinhVien": _maSinhVien.text,
                        "NgaySinh": _ngaySinh.text,
                        "GioiTinh": _gioiTinh.text,
                        "QueQuan": _queQuan.text
                      });
                    },
                    child: Text('S???a'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('SinhVien');
                      collection.doc(_id.text).delete();
                    },
                    child: Text('X??a'),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      CollectionReference collection =
                          FirebaseFirestore.instance.collection('SinhVien');
                      QuerySnapshot querySnapshot = await collection.get();
                      List<DocumentSnapshot> documents = querySnapshot.docs;
                      setState(() {
                        for (var doc in documents) {
                          _output = _output + doc.data().toString();
                        }
                      });
                    },
                    child: Text('In ra'),
                  ),
                  Text(_output),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
