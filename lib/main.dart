import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:votacionesappg12/firebase_options.dart';
import 'package:votacionesappg12/pages/home_page.dart';
import 'package:votacionesappg12/pages/login_page.dart';
import 'package:votacionesappg12/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: LoginPage(), debugShowCheckedModeBanner: false));
}
