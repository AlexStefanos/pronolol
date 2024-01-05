import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/models/match_model.dart';

class Player {
  final String name;
  final int score, rank;

  const Player(this.name, this.score, this.rank);

  int calculateTotalScore() {
    int totalScore = 0;
    //for()
    for (Match match in FirebaseApi.playerPredictions) {
      if (match.bo == 1) {
        if (match.hasPredicted()) {
          if (match.hasPerfectWin()) {
            totalScore += 1;
          } else if (match.hasWin()) {
            totalScore += 1;
          } else {
            //totalScore += 0;
          }
        } else {
          //totalScore += 0;
        }
      } else {
        if (match.hasPredicted()) {
          if (match.hasPerfectWin()) {
            totalScore += 3;
          } else if (match.hasWin()) {
            totalScore += 1;
          } else {
            //totalScore += 0;
          }
        } else {
          //totalScore += 0;
        }
      }
    }
    return totalScore;
  }
}
