import 'package:pronolol/models/team_model.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/M/y');

class Match {
  const Match(this.team1, this.team2, this.score, this.settings, this.date,
      this.result);

  final Team team1;
  final Team team2;
  final List<String> settings;
  final String score;
  final DateTime date;
  final bool result;

  String get formattedDate {
    return formatter.format(date);
  }
}
