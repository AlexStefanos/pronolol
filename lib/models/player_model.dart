import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  const Player(this.name, this.pronos, this.totalPoints);

  int calculatingTotalPoints() {
    int total = 0;
    var collectionRef = FirebaseFirestore.instance.collection('pronostics');
    // collectionRef.get()

    return total;
  }

  final String name;
  final Map<String, List<dynamic>> pronos;
  final int totalPoints;
}
