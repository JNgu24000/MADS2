import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to FitApp!"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(children: [
        Image.asset('assets/RunningMan.gif', height: 375, width: 250),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Welcome to FitApp, for all your workout needs and goals to stay fit!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: const Alignment(-0.3, -0.3),
          child: Row(children: <Widget>[
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: const Text("Register")),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: const Text("Login")),
            const SizedBox(width: 20),
            InkWell(
                onTap: () async {
                  await GoogleSignIn().signIn();
                  Navigator.of(context).pushNamed('/home');
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Center(
                        child: Row(children: <Widget>[
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/google.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ]))))
          ]),
        )
      ])),
    );
  }
}
