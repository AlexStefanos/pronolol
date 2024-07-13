import 'package:intl/intl.dart';
import 'package:pronolol/utils/tournaments.dart';

class Tournament {
  Tournament(this.name, this.logo, this.beginDate);

  Tournaments? name;
  final String? logo;
  final DateTime beginDate;

  final _numericalFormat = DateFormat('dd/MM/y HH:mm', 'fr_FR');

  bool get isFutureTournament {
    return beginDate.isAfter(DateTime.now());
  }

  String nameDisplay() {
    return (name.toString().substring(12).toUpperCase());
  }

  String get numericalDate {
    return _numericalFormat.format(beginDate);
  }

  Tournaments? get tournamentName {
    return name;
  }
}
