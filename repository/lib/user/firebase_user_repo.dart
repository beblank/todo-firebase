import 'package:firebase_auth/firebase_auth.dart';

import 'user_repo.dart';

class FirebaseUserRepo implements UserRepo{

  final FirebaseAuth _firebaseAuth;

  FirebaseUserRepo({FirebaseAuth firebaseAuth})
    :_firebaseAuth=firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> authenticate() => _firebaseAuth.signInAnonymously();
  

  @override
  Future<String> getUserId() async => (await _firebaseAuth.currentUser()).uid;

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

}