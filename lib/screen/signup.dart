import 'package:flutter/material.dart';
import '../domain/local_storage.dart';
import '../model/UserProfile.dart'; // Sesuaikan dengan lokasi file DatabaseHelper

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Create user profile object
      UserProfile userProfile = UserProfile(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      // Simpan userProfile ke penyimpanan atau server
      DatabaseHelper dbHelper = DatabaseHelper(); // Initialize database helper
      await dbHelper.saveUser(userProfile); // Save user to database

      // Tampilkan pesan atau notifikasi signup berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful')),
      );

      // Kembali ke halaman login setelah signup berhasil
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'HarryP'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'HarryP'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'HarryP'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _signup(context),
                  child: Text('Sign Up', style: TextStyle(fontFamily: 'HarryP')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
