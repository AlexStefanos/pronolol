import 'package:pronolol/api/firebase.dart';

class Player {
  final String name;
  final Map<String, List<dynamic>> pronos;
  final int totalPoints;

  const Player(this.name, this.pronos, this.totalPoints);
}
