import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:pronolol/models/country_model.dart';
import 'package:pronolol/models/team_model.dart';

var brazil = Emoji('brazi', '🇧🇷');
var vietnam = Emoji('vietnam', '🇻🇳');
var korea = Emoji('korea', '🇰🇷');
var spain = Emoji('spain', '🇪🇸');

final List<Team> teams = [
  Team('Loud', Country('Brésil', brazil.code), []),
  Team('GAM', Country('Vietnam', vietnam.code), []),
];
