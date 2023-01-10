import 'package:flutter/material.dart';
import 'package:formulario_presenta/main.dart';

class start extends StatefulWidget {
  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    final String user = '@jesus';
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Bienvenido $user',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                )),
                Text('Salir',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  child: Icon(Icons.exit_to_app, size: 30),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "BUSCAR LIBRO",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(suffixIcon: Icon(Icons.book)),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      //HomePage();
                    });
                  },
                  child: Icon(Icons.search, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
