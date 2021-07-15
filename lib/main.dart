import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'sign_up.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: '/signIn',
    routes: {
      '/signIn': (context)=>SignIn(),
      '/signUp':(context)=>SignUp()
    },
      ));
}