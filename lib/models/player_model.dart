import 'package:pronolol/api/firebase.dart';

class Player {
  final String name;
  final Map<String, List<dynamic>> pronos;
  final int totalPoints;

  const Player(this.name, this.pronos, this.totalPoints);

  Future<int> calculatingTotalPoints() async {
    int total = 0;
    final userBets =
        FirebaseApi.bets.where((data) => data['bets'].keys.contains(name));
    for (Map<String, dynamic> userBet in userBets) {
      final winnerTeamIndex = getWinnerTeamIndex(userBet['result']);
      if (userBet['bets']['name'][winnerTeamIndex] == userBet['result']) {
        total += 1;
        if (userBet['bets'][name] == userBet['result']) {
          total += 2;
        }
      }
    }
    return total;
  }

  // TODO: Create a util file
  int getWinnerTeamIndex(String score) {
    return score.codeUnitAt(0) > score.codeUnitAt(1) ? 0 : 1;
  }
}
