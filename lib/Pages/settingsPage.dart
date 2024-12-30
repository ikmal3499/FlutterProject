import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}
class _SettingspageState extends State<Settingspage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';
  bool _notificationsEnabled = true;

  final List<String> languages = ['English', 'Spanish', 'French', 'German'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'English';
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  // Save settings to SharedPreferences
  _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    prefs.setString('language', _selectedLanguage);
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings Page")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // Dark Mode Switch
            SwitchListTile(
              title: Text('Dark Mode'),
              subtitle: Text('Enable dark mode for the app'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
                _saveSettings();
              },
              activeColor: Colors.blue,
            ),
            // Language Dropdown
            ListTile(
              title: Text('Language'),
              subtitle: Text('Change the app language'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                  _saveSettings();
                },
                items: languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Notifications Switch
            SwitchListTile(
              title: Text('Notifications'),
              subtitle: Text('Enable or disable notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _saveSettings();
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}