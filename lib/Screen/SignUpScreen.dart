import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widget/button.dart';
import 'package:flutter_application_1/Widget/textFeild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;

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
              _buildTermsAndConditions(),
              _buildSignUpButton(),
              _buildSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      child: Image.asset("images/6333040.jpg", fit: BoxFit.cover),
    );
  }

  Widget _buildFormSection() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 16),
            TextFeildInput(
              textEditingController: _nameController,
              hintText: "Enter Name",
              icon: Icons.person,
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            TextFeildInput(
              textEditingController: _confirmPasswordController,
              hintText: "Confirm Password",
              icon: Icons.lock,
              isPass: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _termsAccepted,
          onChanged: (value) {
            setState(() {
              _termsAccepted = value ?? false;
            });
          },
        ),
        const Expanded(
          child: Text('I accept the Terms and Conditions'),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MyButton(
        onTab: _signUp,
        text: 'Sign Up',
      ),
    );
  }

  Widget _buildSignInButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Already have an account? Sign In'),
    );
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_termsAccepted) {
        // Show error message if terms are not accepted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must accept the terms and conditions')),
        );
        return;
      }

      // Save user details locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }
}
