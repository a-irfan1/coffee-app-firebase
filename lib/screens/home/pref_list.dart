import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/prefModel.dart';
import 'package:provider/provider.dart';
import 'pref_tile.dart';

class PrefList extends StatefulWidget {
  const PrefList({super.key});

  @override
  State<PrefList> createState() => _PrefListState();
}

class _PrefListState extends State<PrefList> {
  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<List<PrefsModel>>(context) ?? [];
    return ListView.builder(
      itemCount: prefs.length,
      itemBuilder: (context, index) {
        return PrefTile(pref: prefs[index]);
      },
    );
  }
}
