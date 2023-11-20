import 'package:pronolol/models/team_model.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/M/y');

class Match {
  Match(this.id, this.team1, this.team2, this.date, this.bo);

  final String id;
  final Team team1;
  final Team team2;
  final DateTime date;
  final int bo;

  String get formattedDate {
    return formatter.format(date);
  }

  static Match fromFirebase(String id, Map<String, dynamic> data) {
    return Match(id, Team.fromFirebase(data['team1']),
        Team.fromFirebase(data['team2']), data['date'].toDate(), data['bo']);
  }

  bool canBet() {
    return team1.score == 0 && team2.score == 0;
  }

  @override
  String toString() {
    return "${team1.name} ${team1.score} - ${team2.score} ${team2.name}";
  }
}
