import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_getx_starterpack/data/models/user/user.dart';
import 'package:get_storage/get_storage.dart' as get_storage;

class AuthRepository {
  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  final box = get_storage.GetStorage();

  ///
  /// Stream<User> get [user]
  ///
  /// if this function started it will noticed system "is user is SignIn/Signout"
  ///
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      User user =
          firebaseUser == null ? const User.empty() : firebaseUser.toUser;
      if (user is Data) {
        box.write('user_id', user.id);
      }
      return user;
    });
  }

  ///
  /// [loginWithEmailAndPassword]
  ///
  /// Function Login with email and password
  ///
  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw 'Invalid Username Or Password';
    }
  }

  ///
  /// [createUserWithEmailAndPassword]
  ///
  /// Function Creating new account with email and password
  ///
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      throw 'Error 500';
    }
  }

  ///
  /// [loggedOut]
  ///
  /// Function For user is loggedOut
  ///
  Future<void> get loggedOut async {
    await _firebaseAuth.signOut();
  }
}

///
/// firebase_auth.User [User]
///
/// convert [Map] to Model [Dart]
///
extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
