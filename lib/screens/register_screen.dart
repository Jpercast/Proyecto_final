// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:formulario_presenta/services/auth_services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    bool _isObscure = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
      children: [Header(), FormRegistro()],
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
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _usernameController = TextEditingController();
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
          child: Column(children: [
        SizedBox(height: 15),
        TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            label: Text('Nombre de usuario'),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Requerido';
            }
            final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
            if (!isValid) {
              return 'Debe tener una longitud de 3-24 datos ';
            }
            return null;
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _emailController,
          decoration: const InputDecoration(
            label: Text('Email'),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
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
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            label: Text('Contraseña'),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Requerido';
            }
            if (val.length < 6) {
              return '6 datos como minimo';
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () async {
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirmacion;)'),
                          content: const Text(
                              'Felicidades, su cuenta esta registrada'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'))
                          ],
                        ));
              }
              {
                await authService.createUserWithEmailAndPassword(
                    _emailController.text, _passwordController.text);

                {
                  Navigator.pop(context);
                }
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
              width: 120,
              height: 120,
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
                )
                //  style: Estilosletra(context).tituloRegistro),
                ),
          ]),
        )
      ],
    );
  }
}
