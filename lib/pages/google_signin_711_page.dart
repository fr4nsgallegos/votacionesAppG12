import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignin711Page extends StatefulWidget {
  const GoogleSignin711Page({super.key});

  @override
  State<GoogleSignin711Page> createState() => _GoogleSignin711PageState();
}

class _GoogleSignin711PageState extends State<GoogleSignin711Page> {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _account;
  List<String> scopes = [
    "email",
    "https://www.googleapis.com/auth/contacts.readonly",
  ];

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      print("Error al iniciarlizar google: $e");
    }
  }

  Future<void> _ensureGoogleSignInInitizalized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount?> getGoogleAccount() async {
    await _ensureGoogleSignInInitizalized();
    GoogleSignInAccount? account;
    try {
      account = await _googleSignIn.authenticate(scopeHint: scopes);
      _account = account;
      setState(() {});
      return account;
    } on GoogleSignInException catch (e) {
      print("Error de google sign in: $e");
      return null;
    } catch (e) {
      print("Ocurrió un problema: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _account == null
                ? ElevatedButton(
                    onPressed: () {
                      getGoogleAccount();
                    },
                    child: Text("Iniciar sesión con Google"),
                  )
                : Column(
                    children: [
                      Text("Bienvenid@, ${_account?.displayName ?? 'USUARIO'}"),
                      Text("email: ${_account?.email ?? "na"}"),
                      if (_account?.photoUrl != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(_account!.photoUrl!),
                        ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Cerrar sesión"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
