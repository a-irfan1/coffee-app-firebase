import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/userModel.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
