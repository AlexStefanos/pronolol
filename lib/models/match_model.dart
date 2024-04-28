import 'package:pronolol/models/team_model.dart';
import 'package:intl/intl.dart';
import 'package:pronolol/models/tournament_model.dart';
import 'package:pronolol/api/postgres.dart';

class Match {
  Match(this.id, this.team1, this.team2, this.date, this.bo, this.score,
      this.tournament, this.currentUserPrediction);

  final _numericalFormat = DateFormat('dd/MM/y HH:mm', 'fr_FR');
  final _literatureFormat = DateFormat('EEEE dd MMMM', 'fr_FR');
  final _numericalSchedule = DateFormat('HH:mm', 'fr_FR');

  final int id;
  final Team team1;
  final Team team2;
  final DateTime date;
  final int bo;
  final String? score;
  final Tournament tournament;
  String? currentUserPrediction;

  String get numericalDate {
    return _numericalFormat.format(date);
  }

  String get literatureDate {
    return toBeginningOfSentenceCase(_literatureFormat.format(date));
  }

  String get numericalSchedule {
    return _numericalSchedule.format(date);
  }

  bool get isFutureMatch {
    return date.isAfter(DateTime.now());
  }

  bool get currentUserHasPredicted {
    return currentUserPrediction != null;
  }

  bool get isCurrentUserWinner {
    return currentUserPrediction != null &&
        ((score!.codeUnitAt(0) > score!.codeUnitAt(1) &&
                currentUserPrediction![0] == score![0]) ||
            (score!.codeUnitAt(0) < score!.codeUnitAt(1) &&
                currentUserPrediction![1] == score![1]));
  }

  bool get isCurrentUserPerfectWinner {
    return bo > 1 &&
        currentUserPrediction != null &&
        currentUserPrediction![0] == score![0] &&
        currentUserPrediction![1] == score![1];
  }

  static Match fromPostgres(Map<String, dynamic> data) {
    return Match(
        data['id'],
        Team(data['t1_code'], data['t1_url']),
        Team(data['t2_code'], data['t2_url']),
        data['date'],
        data['bo'],
        data['score'],
        Tournament(PostgresApi.getTournamentsName(data['tourn_tricode']),
            data['tourn_logo'], data['beginDate'] ?? DateTime.now()),
        data['result']);
  }
}
