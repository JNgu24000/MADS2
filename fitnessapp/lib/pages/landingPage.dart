import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
              const SizedBox(width: 50),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: const Text("Register")),
              const SizedBox(width: 125),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text("Login"))
            ])),
      ])),
    );
  }
}
