import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Player {
  const Player(this.name, this.pronos, this.totalPoints);

  Future<int> calculatingTotalPoints() async {
    int total = 0, betTeam1 = 0, betTeam2 = 0, resultTeam1 = 0, resultTeam2 = 0;
    String completeBet = '', completeResult = '';
    bool realWinner, betWinner;
    var collectionRef = FirebaseFirestore.instance.collection('pronostics');
    try {
      var bettingMatchDoc =
          await collectionRef.where('bets', isEqualTo: name).get();
      var resultMatchDoc = await collectionRef.where('result').get();
      if (bettingMatchDoc.size > 0) {
        var betValues = bettingMatchDoc.docs.iterator.current.data().values;
        var resultValues = resultMatchDoc.docs.iterator.current.data().values;
        for (int i = 0; i < betValues.length; i++) {
          completeBet = betValues.elementAt(i);
          completeResult = resultValues.elementAt(i);
          betTeam1 = int.parse(completeBet.characters.first);
          betTeam2 = int.parse(completeBet.characters.last);
          resultTeam1 = int.parse(completeResult.characters.first);
          resultTeam2 = int.parse(completeResult.characters.last);
          if (resultTeam1 < resultTeam2) {
            realWinner = false;
          } else {
            realWinner = true;
          }
          if (betTeam1 < betTeam2) {
            betWinner = false;
          } else {
            betWinner = true;
          }
          if ((realWinner && betWinner) || ((!realWinner) && (!betWinner))) {
            total += 1;
            //TODO: il faudrait vérifier si c'est pas un bo1
            if ((betTeam1 == resultTeam1) && (betTeam2 == resultTeam2)) {
              total += 2;
            }
          }
        }
      }
    } catch (e) {
      rethrow;
    }
    return total;
  }

  final String name;
  final Map<String, List<dynamic>> pronos;
  final int totalPoints;
}
