import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(FinanceApp());
}

class FinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5fbfd),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 120.0),
              child: Text(
                'Welcome To Elevate',
                style: TextStyle(
                    color: Color(0xFF19467d),
                    fontFamily: 'Montserrat',
                    fontSize: 30.0),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: FlatButton(
                  color: Color(0xFF19467d),
                  onPressed: (){
                    print('hi');
                    _signInWithGoogle();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      'Sign In With Google',
                      style: TextStyle(color: Color(0xFFf5fbfd), fontFamily: 'Montserrat', fontSize: 15.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_signInWithGoogle() async{
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
}