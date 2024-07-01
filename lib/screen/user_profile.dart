import 'package:flutter/material.dart';
import '../domain/local_storage.dart';
import '../model/UserProfile.dart';

class UserProfilePage extends StatefulWidget {
  final int userId;

  UserProfilePage({required this.userId});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    UserProfile? userProfile = await dbHelper.getUserById(widget.userId);
    if (userProfile != null) {
      setState(() {
        nameController.text = userProfile.name;
        emailController.text = userProfile.email;
        passwordController.text = userProfile.password;
      });
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      UserProfile updatedUser = UserProfile(
        id: widget.userId,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await dbHelper.updateUser(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated')));
    }
  }

  void _deleteProfile() async {
    await dbHelper.deleteUser(widget.userId);

    // Reset text controllers
    nameController.clear();
    emailController.clear();
    passwordController.clear();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _updateProfile,
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
