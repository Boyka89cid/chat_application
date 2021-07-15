import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  final FirebaseAuth _auth = FirebaseAuth.instance; //getting authentication instance of firebase
  FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  Future signUp(String username, String email, String password) async
  {
    try
    {
      UserCredential userCredentials=await _auth.createUserWithEmailAndPassword(email: email, password: password).whenComplete(()
      {
        _firebaseFirestore.collection('Users').add({
          'username':username,
          'email':email
        }).whenComplete(() {print('user Added to cloud Firestore');});
      });
      User user = FirebaseAuth.instance.currentUser; // assigning current user value to the user object of Class User. //print(user?.uid.toString());
      print(user.uid.toString());
      return user;
    } on FirebaseAuthException catch (e)
    {
      if(e.code=='email-already-in-use')
        print('The account already exists for that email.');
    } catch (e) {print(e);}
  }

  Future signIn(String email, String password) async
  {
    try
    {
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = FirebaseAuth.instance.currentUser;
      print(user.uid.toString());
      return user;
    } on FirebaseAuthException catch (e)
    {
      if(e.code=='user-not-found')
        print('No such User found');
      else if(e.code=='wrong-password')
        print('Your Password is wrong');
    } catch(e){print(e);}
  }
}