import 'package:pronolol/api/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  User(this.id, this.name, this.emoji);

  final int id;
  final String name;
  final String emoji;

  static User? currentUser;

  static User fromPostgres(Map<String, dynamic> data) {
    return User(data['id'], data['username'], data['emoji']);
  }

  static Future<void> fetchUser() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? id = instance.getString('id');
    if (id != null) {
      User.currentUser = await PostgresApi.getUserById(id);
    }
  }

  static Future<void> saveUserId(String id) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString('id', id);
    User.currentUser = await PostgresApi.getUserById(id);
  }

  static Future<void> saveUserPin(String cpin) async {
    User.currentUser = await PostgresApi.getUserByPin(cpin);
    String id = User.currentUser!.id.toString();
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString('id', id);
  }

  static Future<void> saveUserPinName(String cpin, String userName) async {
    User.currentUser = await PostgresApi.getUserByPinName(cpin, userName);
    String id = User.currentUser!.id.toString();
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString('id', id);
  }

  static Future<String?> getUserName(String cpin) async {
    String? userName = await PostgresApi.getUserByName(cpin);
    return userName;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, emoji: $emoji}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
