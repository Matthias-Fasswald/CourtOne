// Homepage.dart
import 'package:flutter/material.dart';
import 'BackgroundWidget.dart';
import 'ProfilePage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedMenu = "Benutzerprofil";

  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(
        child: Text("Benutzerprofil", style: TextStyle(color: Colors.white60)),
        value: "Benutzerprofil",
      ),
      DropdownMenuItem(
        child: Text("Tennisplätze in der Nähe", style: TextStyle(color: Colors.white60)),
        value: "Tennisplätze",
      ),
      DropdownMenuItem(
        child: Text("Zahlungsverwaltung", style: TextStyle(color: Colors.white60)),
        value: "Zahlung",
      ),
      DropdownMenuItem(
        child: Text("Abmelden", style: TextStyle(color: Colors.white60)),
        value: "Abmelden",
      ),
    ];
  }

  void _onMenuSelected(String? selected) {
    if (selected != null) {
      setState(() {
        _selectedMenu = selected;
      });
      if (selected == "Benutzerprofil") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()), // Navigiere zur Profilseite
        );
      }
      // Navigation hinzufügen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BackgroundWidget(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Menu",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedMenu,
                    onChanged: _onMenuSelected, // Menüauswahl behandeln
                    items: dropdownItems,
                    isExpanded: true, // Lässt das Dropdown den ganzen Platz nutzen
                    dropdownColor: Colors.grey, // Farbe des Dropdowns
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    icon: const Icon(Icons.arrow_downward), // Dropdown-Pfeil
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
