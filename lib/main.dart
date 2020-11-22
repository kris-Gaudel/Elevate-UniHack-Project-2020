import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//void main() async => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elevate Finance App',
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        Login.id: (context) => Login(),
        Registration.id: (context) => Registration(),
        Input.id: (context) => Input()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  static const String id = 'HOMEPAGE';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Elevate Finance',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Color(0xFF19467d)),
              )
            ],
          ),
          SizedBox(height: 50.0),
          CustomButton(
            labelText: 'Login',
            callBack: () {
              Navigator.of(context).pushNamed(Login.id);
            },
          ),
          CustomButton(
            labelText: 'Register',
            callBack: () {
              Navigator.of(context).pushNamed(Registration.id);
            },
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback callBack;
  final String labelText;
  const CustomButton({this.callBack, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        color: Color(0xFF19467d),
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callBack,
          minWidth: 200.0,
          height: 45.0,
          child: Text(
            labelText,
            style:
                TextStyle(fontFamily: 'Montserrat', color: Color(0xFFf5fbfd)),
          ),
        ),
      ),
    );
  }
}

class Registration extends StatefulWidget {
  static const String id = "REGISTRATION";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register() async {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Input(user: user,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF19467d),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              'Elevate Finance',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Register for Elevate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Montserrat',
                      color: Color(0xFF19467d),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
              hintText: 'Email Address',
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 40.0),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => password = value,
            decoration: InputDecoration(
              hintText: 'Password',
              border: const OutlineInputBorder(),
            ),
          ),
          CustomButton(labelText: 'Register', callBack: () async{
            await register();
          },),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  static const String id = "LOGIN";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    User user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password))
        .user;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Input(user: user,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF19467d),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              'Elevate Finance',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Login to Elevate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Montserrat',
                    color: Color(0xFF19467d),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
              hintText: 'Email Address',
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 40.0),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => password = value,
            decoration: InputDecoration(
              hintText: 'Password',
              border: const OutlineInputBorder(),
            ),
          ),
          CustomButton(labelText: 'Login', callBack: () async{
            await login();
            },
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }
}

class Input extends StatefulWidget {
  static const String id = "INPUT";
  final User user;

  const Input({Key key, this.user}) : super(key: key);
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
