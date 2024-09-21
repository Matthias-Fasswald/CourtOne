// ProfilePage.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BackgroundWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      _nameController.text = user!.displayName ?? '';
      _emailController.text = user!.email ?? '';
    }
  }

  void _updateProfile() async {
    try {
      if (user != null) {
        await user!.updateDisplayName(_nameController.text);
        await user!.updateEmail(_emailController.text);
        if (_passwordController.text.isNotEmpty) {
          await user!.updatePassword(_passwordController.text);
        }
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
          'firstName': _nameController.text,
          'lastName': _lastNameController.text,
          'age': _ageController.text,
          'birthDate': _birthDateController.text,
        });
        await user!.reload();
        user = _auth.currentUser;
        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Profil erfolgreich aktualisiert')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Aktualisieren des Profils: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benutzerprofil'),
      ),
      body: BackgroundWidget(  // Hier wird das BackgroundWidget hinzugefügt
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-Mail'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Passwort (optional)'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                obscureText: true,
              ),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Alter'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextField(
                controller: _birthDateController,
                decoration: const InputDecoration(labelText: 'Geburtsdatum'),
                keyboardType: TextInputType.datetime,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Profil aktualisieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
