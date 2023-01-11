// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formulario_presenta/screens/login_screen.dart';
import 'package:formulario_presenta/screens/register_screen.dart';
import 'package:formulario_presenta/screens/start.dart';
import 'package:formulario_presenta/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register_screen': (context) => FormRegistro(),
          '/start': (context) => Start(),
        },
      ),
    );
  }
}
