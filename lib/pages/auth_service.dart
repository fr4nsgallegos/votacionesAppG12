import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
