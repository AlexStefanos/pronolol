import 'package:pronolol/api/firebase.dart';

class Player {
  const Player(this.name, this.pronos, this.totalPoints);

  Future<int> calculatingTotalPoints() async {
    int total = 0;
    final userBets =
        FirebaseApi.bets.where((data) => data['bets'].keys.contains('Tristan'));
    for (Map<String, dynamic> userBet in userBets) {
      if (userBet['bets']['Caribou'] == userBet['result']) {
        total += 2;
      }
      // TODO: We need to add the other cases
    }
    return total;
  }

  final String name;
  final Map<String, List<dynamic>> pronos;
  final int totalPoints;
}
