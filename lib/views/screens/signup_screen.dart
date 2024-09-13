import 'package:flutter/material.dart';
import 'package:paisa/database/database_methods.dart';
import 'package:paisa/views/custom%20widgets/custom_button.dart';
import 'package:paisa/views/custom%20widgets/custom_text_button.dart';
import 'package:paisa/views/custom%20widgets/custom_textfield.dart';
import 'package:paisa/views/custom%20widgets/google_button.dart';
import 'package:paisa/views/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obsecureText = true;
  onPressedEye() {
    setState(() {
      obsecureText = !obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Center(
                        child: Text(
                          "Paisa",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                      const Text(
                        "Sign up in Paisa !",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        textInputType: TextInputType.visiblePassword,
                        obscureText: obsecureText,
                        hintText: "Password",
                        suffixIcon: obsecureText == true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressedSuffix: () {
                          onPressedEye();
                        },
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        textColor: Colors.white,
                        backgroundColor: Colors.black87,
                        onPressed: () {
                          DatabaseMethods().signUp(
                            emailController.text,
                            passwordController.text,
                            context,
                          );
                          DatabaseMethods().initializeUserData();
                        },
                        text: 'Sign up',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or"),
                          ),
                          Expanded(child: Divider())
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GoogleButton(
                        onPressed: () {},
                        text: "Sign up with Google",
                        icon: 'assets/icon/google logo.svg',
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomTextButton(
                  prefixText: "Already have an account?",
                  buttonText: "Login",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
