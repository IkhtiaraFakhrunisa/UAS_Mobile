import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = 'User Name';
  String _email = 'user@example.com';
  String _bio = 'Bio pengguna';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'User Name';
      _email = prefs.getString('email') ?? 'user@example.com';
      _bio = prefs.getString('bio') ?? 'Bio pengguna';
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
    prefs.setString('email', _email);
    prefs.setString('bio', _bio);
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _saveProfileData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profil diperbarui')));
    }
  }

  void _deleteProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('bio');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profil dihapus')));
    setState(() {
      _name = 'User Name';
      _email = 'user@example.com';
      _bio = 'Bio pengguna';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_placeholder.png'), // Ganti dengan gambar profil pengguna
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan nama';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _bio,
                decoration: InputDecoration(labelText: 'Bio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan bio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _bio = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateProfile,
                child: Text('Perbarui Profil'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _deleteProfile,
                child: Text('Hapus Profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Warna tombol hapus
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
