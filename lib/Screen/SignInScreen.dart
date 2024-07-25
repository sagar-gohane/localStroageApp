import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/button.dart';
import 'package:flutter_application_1/Widget/textFeild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildImageSection(),
              _buildFormSection(),
              _buildSignInButton(),
              _buildForgotPasswordButton(),
              _buildFacebookLoginButton(),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      width: double.infinity,
      child: Image.asset(
        "images/5098293.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildFormSection() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          TextFeildInput(
            textEditingController: _emailController,
            hintText: "Enter Email",
            icon: Icons.email,
          ),
          SizedBox(height: 16),
          TextFeildInput(
            textEditingController: _passwordController,
            hintText: "Enter Password",
            icon: Icons.lock,
            isPass: true,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MyButton(
        onTab: _signIn,
        text: 'Sign In',
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/forgotPassword');
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildFacebookLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Implement Facebook login functionality here
        },
        child: Text('Login with Facebook'),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // Facebook blue color
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: RichText(
        text: const TextSpan(
          text: 'You don\'t have an account? ',
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: <TextSpan>[
            TextSpan(
              text: 'Create an Account',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Save user details locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }
}
