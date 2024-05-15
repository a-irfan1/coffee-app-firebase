import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/prefModel.dart';

class PrefTile extends StatelessWidget {
  final PrefsModel pref;
  PrefTile({super.key, required this.pref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.brown[pref.strength],
            backgroundImage: AssetImage('coffee_icon.png'),
          ),
          title: Text(pref.name),
          subtitle: Text("${pref.sugars} sugars"),
        ),
      ),
    );
  }
}
