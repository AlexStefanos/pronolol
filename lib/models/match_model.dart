import 'dart:developer';

import 'package:pronolol/models/team_model.dart';
import 'package:intl/intl.dart';
import 'package:pronolol/models/user_model.dart';

final formatter = DateFormat('dd/M/y');

class Match {
  Match(this.id, this.team1, this.team2, this.date, this.bo, this.predictions);

  final String id;
  final Team team1;
  final Team team2;
  final DateTime date;
  final int bo;
  final Map<String, dynamic> predictions;

  String get formattedDate {
    return formatter.format(date);
  }

  static Match fromFirebase(String id, Map<String, dynamic> data) {
    return Match(
        id,
        Team(data['team1'], data['score1'] ?? 0),
        Team(data['team2'], data['score2'] ?? 0),
        data['date'].toDate(),
        data['bo'],
        data['predictions']);
  }

  bool canPredict() {
    return date.isAfter(DateTime.now()) && predictions[User.name] == null;
  }

  bool hasPredicted() {
    return predictions[User.name] != null;
  }

  bool hasWin() {
    return (team1.score > team2.score &&
            predictions[User.name][0] == team1.score) ||
        (team1.score < team2.score && predictions[User.name][1] == team2.score);
  }

  bool hasPerfectWin() {
    return predictions[User.name][0] == team1.score &&
        predictions[User.name][1] == team2.score;
  }

  @override
  String toString() {
    return "${team1.name} ${team1.score} - ${team2.score} ${team2.name}";
  }
}
