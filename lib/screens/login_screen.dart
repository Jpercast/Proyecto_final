// ignore_for_file: prefer_const_constructors

import 'package:flutter/Material.dart';
import 'package:formulario_presenta/screens/register_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
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
              ),
              ElevatedButton(
                onPressed: () {
                  authService.signInWithEmailAndPassword(
                      emailController.text, passwordController.text);
                },
                child: Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Aun no tienes cuenta, registrate'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: const Text('Aqui'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
