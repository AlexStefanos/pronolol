class Team {
  Team(this.name, this.logo);

  String name;
  final String logo;

  String properTricode() {
    if (name.length == 2) {
      return name += '  ';
    } else {
      return name;
    }
  }
}
