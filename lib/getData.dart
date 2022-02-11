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
  late String id;
  late String email;
  late String name;

  late String body;

  @override
  void initState() {
    body = "belum ada data";
    id = "";
    email = "";
    name = "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID : ${id}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "NAMA : ${name}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "EMAIL : ${email}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                var res =
                    await http.get(Uri.parse("https://reqres.in/api/users/2"));
                if (res.statusCode == 200) {
                  Map<String, dynamic> data =
                      jsonDecode(res.body) as Map<String, dynamic>;
                  print("BODY : ${data}");
                  setState(() {
                    email = data["data"]["email"].toString();
                    id = data["data"]["id"].toString();
                    name =
                        '${data["data"]["first_name"]} ${data["data"]["last_name"]}';
                  });
                } else {
                  setState(() {
                    body = "ERROR = ${res.statusCode}";
                  });
                }
              },
              child: Text("GET DATA"),
            )
          ],
        ),
      ),
    );
  }
}
