import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/userModel.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0', '1', '2', '3', '4'];

  late String _currentName;
  late String _currentSugars;
  late int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Set Preferences",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) {
                    val!.isEmpty ? 'Enter a name' : null;
                  },
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData?.sugars,
                  items: sugar.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text(
                        "$sugar sugar(s)",
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() {
                    _currentSugars = val!;
                  }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Slider(
                  value: (_currentStrength ?? userData?.strength)!.toDouble(),
                  activeColor:
                      Colors.brown[_currentStrength ?? userData!.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData!.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() {
                    _currentStrength = val.round();
                  }),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.orange),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user!.uid).updateUserData(
                        _currentName ?? userData!.name,
                        _currentSugars ?? userData!.sugars,
                        _currentStrength ?? userData!.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
