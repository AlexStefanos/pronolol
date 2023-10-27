import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:pronolol/data/teams_data.dart';

class Team {
  final String name;
  final String imageUrl;

  Team(this.name, this.imageUrl);

  @override
  String toString() {
    return name;
  }
}

class Match {
  final Team teamA;
  final Team teamB;
  final int scoreA;
  final int scoreB;
  final int bo;

  Match(this.teamA, this.teamB, this.bo, {this.scoreA = 0, this.scoreB = 0});

  @override
  String toString() {
    return '$teamA $scoreA - $scoreB $teamB';
  }

  String designation() {
    if (teamA.name == "TBD" && teamB.name == "TBD") {
      return '';
    }
    return '$teamA-$teamB';
  }

  String score() {
    return '$scoreA$scoreB';
  }
}

class LolEsportApi {
  static List<Match> matches = [];

  static Future getWebsiteData() async {
    LolEsportApi.matches = [];
    final url = Uri.parse(
        'https://lol.fandom.com/wiki/2023_Season_World_Championship/Main_Event');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final games =
        html.getElementsByClassName('mdv-allweeks multirow-highlighter');

    int currentRowNumber = 1;
    for (int i = 0; i < games.length; i++) {
      if (games[i].attributes.containsKey('data-highlight-row') &&
          games[i].attributes['data-highlight-row'] ==
              currentRowNumber.toString()) {
        final teams = _computeTeams(games[i]);
        if (teams.isEmpty) {
          continue;
        }

        final score = _computeScore(games[i]);
        final bo = _computeBo(games[i], score);

        if (score.length != 2) {
          LolEsportApi.matches.add(Match(teams.first, teams.last, bo));
        } else {
          LolEsportApi.matches.add(Match(teams.first, teams.last, bo,
              scoreA: int.parse(score[0]), scoreB: int.parse(score[1])));
        }
        currentRowNumber++;
      }
    }
    LolEsportApi.matches = List.from(LolEsportApi.matches.reversed);
  }

  static List<Team> _computeTeams(dom.Element game) {
    final List<Team> teams = [];
    final names = game.getElementsByClassName('teamname').map((e) => e.text);
    if (names.length == 2) {
      for (int j = 0; j < 2; j++) {
        if (names.elementAt(j).contains('TBD')) {
          teams.add(Team(names.elementAt(j),
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/TBD-W.svg/1200px-TBD-W.svg.png'));
        } else {
          teams.add(Team(names.elementAt(j), teamsLogo[names.elementAt(j)]!));
        }
      }
    }
    return teams;
  }

  static List<String> _computeScore(dom.Element game) {
    return game
        .getElementsByTagName('td')
        .map((e) => e.text)
        .elementAt(2)
        .split(' - ')
        .map((e) => e == 'TBD' ? '0' : e)
        .toList();
  }

  static int _computeBo(dom.Element game, List<String> score) {
    var bo = int.parse(game.firstChild?.attributes['rowspan'] ?? '1');
    if (bo % 2 == 0) {
      bo++;
    }
    if (bo != 1 &&
        score.length == 2 &&
        (int.parse(score[0]) == bo || int.parse(score[1]) == bo)) {
      bo += 2;
    }
    return bo;
  }
}
