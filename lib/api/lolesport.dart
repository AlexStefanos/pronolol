import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

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

  Match(this.teamA, this.teamB, {this.scoreA = 0, this.scoreB = 0});

  @override
  String toString() {
    if (scoreA == 0 && scoreB == 0) {
      return '$teamA TBD - TBD $teamB';
    }
    return '$teamA $scoreA - $scoreB $teamB';
  }
}

class LolEsportApi {
  static List<Match> previousMatches = [];
  static List<Match> futureMatches = [];

  static Future getWebsiteData() async {
    LolEsportApi.previousMatches = [];
    LolEsportApi.futureMatches = [];
    final url = Uri.parse(
        'https://lol.fandom.com/wiki/2023_Season_World_Championship/Play-In');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final games =
        html.getElementsByClassName('mdv-allweeks multirow-highlighter');

    int currentRowNumber = 1;
    for (int i = 0; i < games.length; i++) {
      if (games[i].attributes.containsKey('data-highlight-row') &&
          games[i].attributes['data-highlight-row'] ==
              currentRowNumber.toString()) {
        final names =
            games[i].getElementsByClassName('teamname').map((e) => e.text);
        final logos = games[i]
            .getElementsByTagName('img')
            .map((e) => e.attributes['src'].toString());

        if (names.length != 2 && logos.length != 2) {
          continue;
        }

        final teams = [];
        for (int j = 0; j < 2; j++) {
          teams.add(Team(names.elementAt(j), logos.elementAt(j)));
        }

        final score = games[i]
            .getElementsByTagName('td')
            .map((e) => e.text)
            .elementAt(2)
            .split(' - ');

        if (score.contains('TBD')) {
          LolEsportApi.futureMatches.add(Match(teams.first, teams.last));
        } else {
          LolEsportApi.previousMatches.add(Match(teams.first, teams.last,
              scoreA: int.parse(score[0]), scoreB: int.parse(score[1])));
          currentRowNumber++;
        }
      }
    }
    LolEsportApi.previousMatches =
        List.from(LolEsportApi.previousMatches.reversed);
    LolEsportApi.futureMatches = List.from(LolEsportApi.futureMatches.reversed);
  }
}
