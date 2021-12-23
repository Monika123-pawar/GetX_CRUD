import 'package:crud_getx/app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: "Email"),
            controller: _emailController,
          ),
          TextField(
            decoration: const InputDecoration(hintText: "Password"),
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async{
                    authController.register(_emailController.text.trim(),
                        _passwordController.text.trim()
                    );
                  },
                  child: Text('Sign Up')),
              ElevatedButton(
                  onPressed: () async{
                    authController.register(_emailController.text.trim(),
                        _passwordController.text.trim()
                    );
                  },
                  child: Text('Login')),
            ],
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
              onPressed: () {
                authController.signInWithGoogle();
              },
              child: Text('Sign in with Google')),
        ],
      ),
    );
  }
}
