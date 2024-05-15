import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/settings_form.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'pref_list.dart';
import 'package:flutter_firebase/Models/prefModel.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showBottomPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<PrefsModel>>.value(
      value: DatabaseService(uid: '').prefs,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.blueAccent[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
            TextButton.icon(
              onPressed: () {
                _showBottomPanel();
              },
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
          ],
          title: Text("Flutter Firebase"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('coffee_bg.png'),
            ),
          ),
          child: PrefList(),
        ),
      ),
    );
  }
}
