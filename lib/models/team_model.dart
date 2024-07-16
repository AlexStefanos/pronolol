class Team {
  Team(this.name, this.logo);

  String name;
  final String logo;

  String cleanTricode() {
    String result = name;
    if (result.length == 2) {
      return result += '  ';
    } else {
      return result;
    }
  }
}
