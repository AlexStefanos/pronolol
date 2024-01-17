import 'package:pronolol/models/user_model.dart';

class Prediction {
  const Prediction(this.user, this.result);

  final User user;
  final String result;

  static Prediction fromPostgres(Map<String, dynamic> data) {
    return Prediction(User.fromPostgres(data), data['result']);
  }
}
