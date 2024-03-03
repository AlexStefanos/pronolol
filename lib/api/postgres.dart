import 'package:postgres/postgres.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/prediction_model.dart';
import 'package:pronolol/models/user_model.dart';

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

  static Future<List<String>> getUsers() async {
    final result = await execute('SELECT username FROM users;');
    return result.map((e) {
      return e[0].toString();
    }).toList();
  }

  static Future<List<Match>> getMatchesToCome() async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN predictions p on m.id = p.match_id AND p.user_id = ${User.currentUser!.id}
        WHERE m.date >= NOW() AND date < NOW() + INTERVAL '10 days'
        ORDER BY m.date;
        ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<List<Match>> getPastMatches() async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, m.score, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        LEFT JOIN predictions p on m.id = p.match_id AND p.user_id = ${User.currentUser!.id}
        WHERE m.date < NOW()
        ORDER BY m.date DESC;
        ''');
    return result.map((e) => Match.fromPostgres(e.toColumnMap())).toList();
  }

  static Future<void> addPrediction(int matchId, String score) async {
    await execute('''
        INSERT INTO predictions (match_id, user_id, result)
        VALUES ($matchId, ${User.currentUser!.id}, '$score')
        ''');
  }

  static Future<List<(Match, String)>> getUserPredictions() async {
    final result = await execute('''
        SELECT m.id, t1.tricode as t1_code, t1.logo_url as t1_url, t2.tricode as t2_code, t2.logo_url as t2_url, m.date, m.bo, m.score, p.result
        FROM matches m
        LEFT JOIN teams t1 on m.team1 = t1.id
        LEFT JOIN teams t2 on m.team2 = t2.id
        INNER JOIN predictions p on m.id = p.match_id
        WHERE p.user_id = ${User.currentUser!.id}
        ORDER BY m.date DESC;
        ''');
    return result.map((e) {
      var map = e.toColumnMap();
      return (Match.fromPostgres(map), map['result'].toString());
    }).toList();
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

  static Future<List<MapEntry<User, int>>> getCurrentRanking() async {
    final result = await execute('''
        SELECT u.id, u.username, u.emoji, p.result, m.score, m.bo
        FROM users u
        INNER JOIN predictions p on u.id = p.user_id
        INNER JOIN matches m on p.match_id = m.id
        WHERE m.date > '2024-03-01 12:00:00';
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
}
