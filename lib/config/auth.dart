import 'package:firebase_auth/firebase_auth.dart';
import 'package:connection/modal/userData.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData _userFromFirebaseUser(User user){
    return user != null ? UserData(userId: user.uid) : null;
  }

  Future signInWithEmail(String _email, String _password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      User _firebaseUser = result.user;
      return _userFromFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmail(String _email, String _password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User _firebaseUser = result.user;
      return _userFromFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String _email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: _email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}
