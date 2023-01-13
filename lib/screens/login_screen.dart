import 'package:flutter/Material.dart';
import 'package:formulario_presenta/screens/register_screen.dart';
import 'package:formulario_presenta/screens/start.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? checkGuardarDatos = false;
  SharedPreferences? _prefs;

  Future<void> cargarPreferencias() async {
    SharedPreferences? _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    cargarPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
          Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      validator: (String? value) {
                        if (!value!.contains('@')) {
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
                      validator: (String? value) {
                        return (value!.length > 8)
                            ? 'Su contraseña debe tener 8 dígitos'
                            : null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      {
                        authService.signInWithEmailAndPassword(
                            emailController.text, passwordController.text);
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookSearchPage()));
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 6),
                        CheckboxListTile(
                          value: checkGuardarDatos,
                          title: const Text('Guardar mis datos'),
                          onChanged: (value) {
                            setState(() {
                              checkGuardarDatos = value;
                            });
                          },
                          secondary: const Icon(Icons.safety_check),
                        )
                      ],
                    ),
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
            ),
          ),
        ],
      ),
    );
  }
}
