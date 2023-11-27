import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static const List<String> users = [
    "Alex",
    "Quentin",
    "Kazou",
    "Caribou",
    "Pully",
    "Nathan"
  ];
  static String? name;

  // Get user from shared preferences
  static Future<void> getUser() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    name = instance.getString("user");
  }

  // Save user in shared preferences
  static Future<void> saveUser(String user) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("user", user);
    name = user;
  }

  static Future<void> showSelectUserModal(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: users
                .map((user) => FilledButton(
                    onPressed: () => User.saveUser(user)
                        .then((value) => Navigator.pop(context)),
                    child: Text(user)))
                .toList());
      },
    );
  }
}
