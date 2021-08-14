import 'package:flutter/material.dart';
import 'package:lovepeople_firebase/pages/home.dart';
import 'package:lovepeople_firebase/repository/auth_repository.dart';

class LoginPage extends StatefulWidget {
  static Map route = {
    '/': (context) => LoginPage(),
  };
  static String routeName = '/';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthRepository _authRepository;
  @override
  void initState() {
    _authRepository = AuthRepository();
    _verifyUserSign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Login Google'),
          onPressed: _signGoogle,
        ),
      ),
    );
  }

  _goHome() {
    Navigator.of(context).pushNamed(HomePage.routeName);
  }

  void _verifyUserSign() async {
    final user = await _authRepository.getUserSign();
    if (user != null) {
      _goHome();
    }
  }

  void _signGoogle() async {
    final user = await _authRepository.signInGoogle();
    if (user != null) {
      _goHome();
    }
  }
}
