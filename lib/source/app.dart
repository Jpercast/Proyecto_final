import 'package:flutter/Material.dart';
import 'package:formulario_presenta/main.dart';
import 'package:formulario_presenta/screens/start.dart';

class MyAppForm extends StatefulWidget {
  const MyAppForm({super.key});

  @override
  State<MyAppForm> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: header(),
    );
  }
}

class header extends StatelessWidget {
  const header({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        Body(),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 35),
      width: double.infinity,
      height: 200,
      color: Color.fromARGB(188, 106, 159, 234),
      child: Column(children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            border:
                Border.all(width: 5, color: Color.fromARGB(255, 3, 15, 149)),
            image: DecorationImage(
                image: AssetImage('assets/github.png'), fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            ' INICIAR SESIÓN GITHUB',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ]),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final user = 'jesus@certus.edu.pe';
    final pass = 'certus';

    var email = TextEditingController();
    var password = TextEditingController();

    return Column(children: [
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text('Usuario',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: 10),
        width: 250,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'usuario@gmail.com',
            suffixIcon: Icon(Icons.verified_user,
                color: Color.fromARGB(255, 38, 168, 255)),
          ),
          controller: email,
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text('Contraseña',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: 10),
        width: 250,
        child: TextField(
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Ingrese Aqui',
              suffixIcon: Icon(Icons.password,
                  color: Color.fromARGB(255, 38, 168, 255))),
          controller: password,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 40),
      ),
      Container(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[400],
          child: Icon(Icons.login),
          onPressed: () {
            if (email.text.toLowerCase() == user &&
                password.text.toLowerCase() == pass) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => start()));
            } else if (email.text.toLowerCase() != user ||
                password.text.toLowerCase() != pass) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('INCORRECTO'),
                  );
                },
              );
            }
          },
        ),
      ),
    ]);
  }
}
