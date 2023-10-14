import 'package:pronolol/models/country.dart';
import 'package:pronolol/models/match.dart';

class Team {
  const Team(this.name, this.country, this.history);

  final String name;
  final Country country;
  final List<Match> history;
}
