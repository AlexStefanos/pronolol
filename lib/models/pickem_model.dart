import 'package:pronolol/models/tournament_model.dart';

class Pickem {
  Pickem(this.id, this.question, this.points, this.tournament, this.answers,
      this.currentUserPrediction, this.answer);

  final int id;
  final String question;
  final int points;
  final Tournament tournament;
  final List<String> answers;
  String? currentUserPrediction;
  final String answer;

  bool get currentUserHasPredicted {
    return currentUserPrediction != null;
  }
}
