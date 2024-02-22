import 'package:admin/controller/admin_controller.dart';
import 'package:admin/views/Navigation.dart';
import 'package:admin/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminController>(
          create: (context) => AdminController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (FirebaseAuth.instance.currentUser!.uid ==
                    'rhI5kx8KWPSUvRMfjfcIik1HhSm2') {
                  return const NavBar();
                } else {
                  return const LoginPage();
                }
              } else {
                return const LoginPage();
              }
            }),
      ),
    );
  }
}
