import 'package:authflutter/components/my_button.dart';
import 'package:authflutter/components/my_textfield.dart';
import 'package:authflutter/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try agian
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'worng-password') {
        worngPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email'),
          );
        });
  }

  void worngPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Password'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                // wellcomeback
                Text(
                  "ยินดีต้อนรับ !",
                  style: TextStyle(color: Colors.grey[700], fontSize: 18),
                ),
                const SizedBox(
                  height: 50,
                ),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: "email",
                  obscrueText: false,
                ),
                const SizedBox(
                  height: 10,
                ),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "password",
                  obscrueText: true,
                ),
                const SizedBox(
                  height: 10,
                ),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "ลืมรหัสผ่าน?",
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // sign in button
                MyButton(onTap: signUserIn),

                const SizedBox(
                  height: 50,
                ),

                // or continue with

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[500],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'หรือ',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // google + apple sign in
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google
                    SquareTile(
                      imagePath: 'lib/images/google.png',
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    // apple
                    SquareTile(
                      imagePath: 'lib/images/facebook.png',
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),

                // not a member ? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ยังไม่เป็นสมาชิกหรอ? ',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    Text(
                      'ลงทะเบียนเลย',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
