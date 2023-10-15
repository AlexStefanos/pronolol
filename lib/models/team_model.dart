import 'package:pronolol/models/country_model.dart';
import 'package:pronolol/models/match_model.dart';

class Team {
  const Team(this.name, this.country, this.history);

  final String name;
  final Country country;
  final List<Match> history;
}
