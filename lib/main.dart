import 'package:app_simple/Presentation/page/Login_screen.dart';
import 'package:app_simple/core/Routing/App_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final GoRouter customrouter = GoRouter(
                initialLocation: snapshot.data != null ? '/home' : '/login',
                routes: appRoute);
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: customrouter,
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ),
            );
          }
        });
  }
}
