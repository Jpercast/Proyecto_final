import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formulario_presenta/services/push_notification.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificacionService.initializeApp();
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
          // xd '/': (context) => Wrapper(),
          '/': (context) => LoginScreen(),
          '/register_screen': (context) => RegisterScreen(),
          '/home_screen': (context) => BookSearchPage(),
        },
      ),
    );
  }
}