import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario_presenta/screens/cargarimagen.dart';
import 'package:formulario_presenta/screens/start.dart';
import 'package:formulario_presenta/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: [
          IconButton(
              icon: Icon(Icons.browse_gallery),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SubirImagen(title: 'Cargar imagen')));
              })
        ],
      ),
      body: const Contenido(),
    );
  }
}

class Contenido extends StatelessWidget {
  const Contenido({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        FormRegistro(),
      ],
    );
  }
}

class FormRegistro extends StatefulWidget {
  const FormRegistro({
    Key? key,
  }) : super(key: key);

  @override
  State<FormRegistro> createState() => _FormRegistroState();
}

class _FormRegistroState extends State<FormRegistro> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: 15),
            TextFormField(
              controller: usernameController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
              ],
              decoration: const InputDecoration(
                label: Text('Nombre de usuario'),
              ),
              validator: (String? value) {
                if (!validator.name(value!)) {
                  return 'Requerido';
                }
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              validator: (String? value) {
                if (!value!.contains('@')) {
                  return 'Requerido';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Contraseña'),
              ),
              validator: (String? value) {
                return (value!.length > 8)
                    ? 'Su contraseña debe tener 8 dígitos'
                    : null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authService.createUserWithEmailAndPassword(
                        emailController.text, passwordController.text);
                  }
                  {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirmacion;)'),
                              content: const Text(
                                  'Felicidades, su cuenta esta registrada'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookSearchPage()));
                                    },
                                    child: Text('Ok'))
                              ],
                            ));
                  }
                },
                child: const Text('Registar')),
            SizedBox(height: 10),
            const Center(
              child: Text('¿Tienes una cuenta?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('      Conectate por'),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Aqui'),
                ),
              ],
            )
          ])),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 35),
          width: double.infinity,
          height: 200,
          color: Color.fromARGB(188, 106, 159, 234),
          child: Column(children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                    width: 5, color: Color.fromARGB(255, 3, 15, 149)),
                image: DecorationImage(
                    image: AssetImage('assets/github.png'), fit: BoxFit.cover),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'MY VIRTUAL BOOK',
                )),
          ]),
        )
      ],
    );
  }
}
