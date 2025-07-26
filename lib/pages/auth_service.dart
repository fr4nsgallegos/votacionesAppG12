import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:votacionesappg12/pages/home_page.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String mapErrorAuth(String errorMessage) {
    if (errorMessage.contains("invalid-credential")) {
      return "Usuario o contraseña inválidos";
    } else if (errorMessage.contains("badlt-formatted")) {
      return "Correo incorrecto";
    } else if (errorMessage.contains("auth credential")) {
      return "Usuario o contraseña inválidos";
    } else {
      return "Ocurrio un error al iniciar sesión";
    }
  }

  static Future<User?> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error en el registro del corre ${e.message}");
      rethrow;
    } catch (e) {
      print("otro tipo de error: ${e}");
      rethrow;
    }
  }

  static Future<void> createUserInFirestore(
    User user,
    String nombre,
    String phone,
    String birthday,
  ) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection("users")
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        await _firestore.collection("users").doc(user.uid).set({
          "email": user.email,
          "name": nombre,
          "phone": phone,
          "birthday": birthday,
          "createdAt": Timestamp.now(),
        });
      }
    } catch (e) {
      print("error al crear usuario en firestor: $e");
      rethrow;
    }
  }

  static Future<User?> loginWithEmailPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(mapErrorAuth(e.message ?? e.code)),
        ),
      );
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(25),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
        ),
      );
      return null;
    }
  }
}
