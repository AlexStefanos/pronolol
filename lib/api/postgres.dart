import 'package:postgres/postgres.dart';
import 'package:pronolol/models/champion_model.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/pickem_model.dart';
import 'package:pronolol/models/prediction_model.dart';
import 'package:pronolol/models/tournament_model.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/utils/tournaments.dart';

class PostgresApi {
  static Future<Result> execute(String query) async {
    final conn = await Connection.open(
        Endpoint(
            host: 'pronolol-do-user-15603777-0.c.db.ondigitalocean.com',
            database: 'main',
            username: 'doadmin',
            password: 'AVNS_9EGTm7dmob9Nwfdwuwx',
            port: 25060),
        settings: const ConnectionSettings(sslMode: SslMode.require));
    final result = await conn.execute(query);
    await conn.close();
    return result;
  }

  static Future<User> getUserById(String id) async {
    final result = await execute('SELECT * FROM users WHERE id = $id;');
    return User.fromPostgres(result.first.toColumnMap());
  }

  static Future<User?> getUserByPin(String cpin) async {
    final result = await execute('SELECT * FROM users WHERE cpin = \'$cpin\';');
    return User.fromPostgres(result.first.toColumnMap());
  }

  static Future<List<String>> getUsers() async {
    final result = await execute('SELECT username FROM users;');
    return result.map((e) {
      return e[0].toString();
    }).toList();
  }

  static Future<void> createUser(String cpin, userName, userEmoji) async {
    await execute(
        'INSERT INTO users (id, username, emoji, cpin) VALUES ((SELECT MAX(id)+1 FROM users), \'$userName\', \'$userEmoji\', \'$cpin\');');
    await User.saveUserPin(cpin);
  }

  static Future<void> updateUser(
      String cpin, String userName, String userEmoji) async {
    await execute(
        'UPDATE users SET username = \'$userName\', emoji = \'$userEmoji\' WHERE cpin = \'$cpin\';');
  }

  static Future<bool> doesUserExists(String cpin) async {
    final result = await execute('SELECT * FROM users WHERE cpin = \'$cpin\';');
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Tournaments getTournamentsName(Object? e) {
    for (var value in Tournaments.values) {
      if (value.name == e.toString()) {
        return (value);
      }
    }
    return Tournaments.msi;
  }

  static Future<List<Champion>> getChampions() async {
    final result = await execute('SELECT * FROM champions ORDER BY name;');
    return result.map((e) {
      return Champion(e[1].toString(), e[2].toString());
    }).toList();
  }

  static Future<List<Pickem>> getPickemsQuestions(
      Tournaments tournament) async {
    final result = await execute('SELECT * FROM pickems ORDER BY id;');
    return result.map((e) {
      return Pickem(
          int.parse(e[0].toString()),
          e[1].toString(),
          int.parse(e[3].toString()),
          Tournament(
              tournament,
              'https://static.wikia.nocookie.net/lolesports_gamepedia_en/images/9/97/Mid-Season_Invitational_2019.png/revision/latest?cb=20230512021227',
              DateTime.parse('2024-05-01 08:00:00.000000 +00:00')),
          List.empty(),
          '',
          '');
    }).toList();
  }

  static Future<List<Match>> getMatchesToCome() async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, tourn.tricode as tourn_tricode, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        LEFT JOIN predictions p on m.id = p.match_id AND p.user_id = ${User.currentUser!.id}
        WHERE m.date >= NOW() AND date < NOW() + INTERVAL '10 days'
        ORDER BY m.date;
        ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<List<Match>> getSpecificMatchesToCome(String tournament) async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, tourn.tricode, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        LEFT JOIN predictions p on m.id = p.match_id AND p.user_id = ${User.currentUser!.id}
        WHERE m.tournament = '$tournament' AND m.date >= NOW() AND date < NOW() + INTERVAL '10 days'
        ORDER BY m.date;
        ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<List<Match>> getPastMatches() async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, m.score, tourn.tricode, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        LEFT JOIN predictions p on m.id = p.match_id AND p.user_id = ${User.currentUser!.id}
        WHERE m.date < NOW()
        ORDER BY m.date DESC;
        ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<List<Match>> getSpecificPastMatches(String tournament) async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, m.score, tourn.tricode, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        LEFT JOIN predictions p on m.id = p.match_id AND p.user_id = ${User.currentUser!.id}
        WHERE m.tournament = '$tournament' AND m.date < NOW()
        ORDER BY m.date DESC;
        ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<void> addPrediction(int matchId, String score) async {
    final result =
        await execute('''SELECT date FROM matches WHERE id = $matchId''');
    String tmpDate =
        result.map((e) => e.toColumnMap()).toList()[0].values.toString();
    DateTime date = DateTime.parse(tmpDate.substring(1, tmpDate.length - 2));
    if (date.isAfter(DateTime.now())) {
      await execute('''
          INSERT INTO predictions (match_id, user_id, result)
          VALUES ($matchId, ${User.currentUser!.id}, '$score')
          ''');
    }
  }

  static Future<void> updatePrediction(int matchId, String score) async {
    final result =
        await execute('''SELECT date FROM matches WHERE id = $matchId''');
    String tmpDate =
        result.map((e) => e.toColumnMap()).toList()[0].values.toString();
    DateTime date = DateTime.parse(tmpDate.substring(1, tmpDate.length - 2));
    if (date.isAfter(DateTime.now())) {
      await execute('''
        UPDATE predictions SET result = '$score'
        WHERE match_id = $matchId AND user_id = ${User.currentUser!.id}
        ''');
    }
  }

  static Future<List<(Match, String)>> getUserPredictions() async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, m.score, tourn.tricode, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        INNER JOIN predictions p on m.id = p.match_id
        WHERE m.tournament IN (SELECT tournament FROM tournaments HAVING COUNT(DISTINCT tricode) = 7) AND p.user_id = ${User.currentUser!.id}
        ORDER BY m.date DESC;
        ''');
    return result.map((e) {
      var map = e.toColumnMap();
      return (Match.fromPostgres(map), map['result'].toString());
    }).toList();
  }

  static Future<List<(Match, String)>> getUserSpecificPredictions(
      String tournament) async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, m.score, tourn.tricode, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        INNER JOIN predictions p on m.id = p.match_id
        WHERE m.tournament = '$tournament' AND p.user_id = ${User.currentUser!.id}
        ORDER BY m.date DESC;
        ''');
    return result.map((e) {
      var map = e.toColumnMap();
      return (Match.fromPostgres(map), map['result'].toString());
    }).toList();
  }

  static Future<List<MapEntry<User, int>>> getCurrentRanking() async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result, m.score, m.bo
        FROM users u
        INNER JOIN predictions p on u.id = p.user_id
        INNER JOIN matches m on p.match_id = m.id
        WHERE m.date > (SELECT begindate FROM tournaments WHERE begindate = (SELECT MIN(begindate) FROM tournaments));
        ''');

    Map<User, int> ranking = {};

    for (var row in result) {
      var map = row.toColumnMap();
      User user = User.fromPostgres(map);
      if (ranking[user] == null) {
        ranking[user] = 0;
      }
      if (map['result'] == map['score']) {
        int bo = map['bo'];
        ranking[user] = ranking[user]! + (bo / 2).floor();
      }
      if ((map['score'].toString().codeUnits[0] >
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[0] ==
                  map['score'].toString().codeUnits[0]) ||
          (map['score'].toString().codeUnits[0] <
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[1] ==
                  map['score'].toString().codeUnits[1])) {
        ranking[user] = ranking[user]! + 1;
      }
    }
    return ranking.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  }

  static Future<List<MapEntry<User, int>>> getSpecificCurrentRanking(
      String tournamentTricode) async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result, m.score, m.bo
        FROM users u
        INNER JOIN predictions p on u.id = p.user_id
        INNER JOIN matches m on p.match_id = m.id
        WHERE m.tournament = '$tournamentTricode' AND m.date > (SELECT begindate FROM tournaments WHERE tricode = '$tournamentTricode');
        ''');

    Map<User, int> ranking = {};

    for (var row in result) {
      var map = row.toColumnMap();
      User user = User.fromPostgres(map);
      if (ranking[user] == null) {
        ranking[user] = 0;
      }
      if (map['result'] == map['score']) {
        int bo = map['bo'];
        ranking[user] = ranking[user]! + (bo / 2).floor();
      }
      if ((map['score'].toString().codeUnits[0] >
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[0] ==
                  map['score'].toString().codeUnits[0]) ||
          (map['score'].toString().codeUnits[0] <
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[1] ==
                  map['score'].toString().codeUnits[1])) {
        ranking[user] = ranking[user]! + 1;
      }
    }
    return ranking.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  }

  static Future<List<MapEntry<User, int>>> getGlobalRanking() async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result, m.score, m.bo
        FROM users u
        INNER JOIN predictions p on u.id = p.user_id
        INNER JOIN matches m on p.match_id = m.id
        WHERE m.date < NOW();
        ''');

    Map<User, int> ranking = {};

    for (var row in result) {
      var map = row.toColumnMap();
      User user = User.fromPostgres(map);
      if (ranking[user] == null) {
        ranking[user] = 0;
      }
      if (map['result'] == map['score']) {
        int bo = map['bo'];
        ranking[user] = ranking[user]! + (bo / 2).floor();
      }
      if ((map['score'].toString().codeUnits[0] >
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[0] ==
                  map['score'].toString().codeUnits[0]) ||
          (map['score'].toString().codeUnits[0] <
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[1] ==
                  map['score'].toString().codeUnits[1])) {
        ranking[user] = ranking[user]! + 1;
      }
    }
    return ranking.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  }

  static Future<List<MapEntry<User, int>>> getSpecificGlobalRanking(
      String tournament) async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result, m.score, m.bo
        FROM users u
        INNER JOIN predictions p on u.id = p.user_id
        INNER JOIN matches m on p.match_id = m.id
        WHERE m.tournament = '$tournament' AND m.date < NOW();
        ''');

    Map<User, int> ranking = {};

    for (var row in result) {
      var map = row.toColumnMap();
      User user = User.fromPostgres(map);
      if (ranking[user] == null) {
        ranking[user] = 0;
      }
      if (map['result'] == map['score']) {
        int bo = map['bo'];
        ranking[user] = ranking[user]! + (bo / 2).floor();
      }
      if ((map['score'].toString().codeUnits[0] >
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[0] ==
                  map['score'].toString().codeUnits[0]) ||
          (map['score'].toString().codeUnits[0] <
                  map['score'].toString().codeUnits[1] &&
              map['result'].toString().codeUnits[1] ==
                  map['score'].toString().codeUnits[1])) {
        ranking[user] = ranking[user]! + 1;
      }
    }
    return ranking.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  }

  static Future<List<Prediction>> getMatchPredictionsById(int id) async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result
        FROM users u
        INNER JOIN predictions p on u.id = p.user_id
        WHERE p.match_id = $id;
        ''');
    return result.map((e) => Prediction.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<List<Prediction>> getPickemPredictionsById(int id) async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result
        FROM users u
        INNER JOIN pickems_predictions p on u.id = p.user_id
        WHERE p.question_id = $id;
        ''');
    return result.map((e) => Prediction.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<String> getCurrentTournament() async {
    final result = await execute('''
        SELECT description FROM tournaments WHERE begindate = (SELECT MIN(begindate) FROM tournaments) 
    ''');
    return result[0][0].toString();
  }

  static Future<List<Match>> getTeamPreviousMatches(String team) async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.score, m.bo, tourn.tricode as tourn_tricode
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN tournaments tourn on m.tournament = tourn.tricode
        WHERE (t1.tricode = '$team' OR t2.tricode = '$team') AND m.date <= NOW()
        ORDER BY m.date DESC;
    ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }
}
