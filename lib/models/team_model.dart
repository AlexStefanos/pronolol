class Team {
  const Team(this.name, this.score);

  final String name;
  final int score;

  static Team fromFirebase(Map<String, dynamic> data){
    return Team(data['name'], data['score']);
  }
}
