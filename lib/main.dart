import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilResponse = 'Belum ada data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP POST"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: jobC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: nameC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nama",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              var res = await http
                  .patch(Uri.parse("https://reqres.in/api/users/1"), body: {
                "name": nameC.text,
                "job": jobC.text,
              });

              Map<String, dynamic> data =
                  jsonDecode(res.body) as Map<String, dynamic>;
              setState(() {
                hasilResponse = "${data['name']} - ${data['job']}";
              });
              print(res.body);
            },
            child: Text("Submit"),
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 50,
          ),
          Text(hasilResponse),
        ],
      ),
    );
  }
}
