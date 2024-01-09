import 'package:pronolol/models/team_model.dart';
import 'package:intl/intl.dart';

class Match {
  Match(this.id, this.team1, this.team2, this.date, this.bo, this.score,
      this.predictions);

  final _numericalFormat = DateFormat('dd/MM/y HH:mm', 'fr_FR');
  final _literatureFormat = DateFormat('EEEE dd MMMM', 'fr_FR');

  final String id;
  final Team team1;
  final Team team2;
  final DateTime date;
  final int bo;
  final String score;
  final Map<String, dynamic> predictions;

  String get numericalDate {
    return _numericalFormat.format(date);
  }

  String get literatureDate {
    return _literatureFormat.format(date).toUpperCase();
  }

  static Match fromFirebase(String id, Map<String, dynamic> data) {
    return Match(
        id,
        Team(data['team1']),
        Team(data['team2']),
        data['date'].toDate(),
        data['bo'],
        data['score'] ?? '00',
        data['predictions']);
  }

  bool isFutureMatch() {
    if (date.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  bool canPredict(String user) {
    return isFutureMatch() && predictions[user] == null;
  }

  bool hasPredicted(String user) {
    return predictions[user] != null;
  }

  bool hasWin(String user) {
    return (score.codeUnitAt(0) > score.codeUnitAt(1) &&
            predictions[user].toString()[0] == score[0]) ||
        (score.codeUnitAt(0) < score.codeUnitAt(1) &&
            predictions[user].toString()[1] == score[1]);
  }

  bool hasPerfectWin(String user) {
    return predictions[user].toString()[0] == score[0] &&
        predictions[user].toString()[1] == score[1];
  }

  String toStringFromUserPrediction(String user) {
    return '${team1.name} ${predictions[user].toString()[0]} - ${predictions[user].toString()[1]} ${team2.name}';
  }

  @override
  String toString() {
    return '${team1.name} ${score[0]} - ${score[1]} ${team2.name}';
  }
}
