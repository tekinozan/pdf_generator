import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class UserPreferences{
  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _keyJob = 'job';

  Future saveUser(User user) async {
    final _preferences = await SharedPreferences.getInstance();

    await _preferences.setString(_keyUsername, user.username.toString());
    await _preferences.setString(_keyPassword, user.password.toString());
    await _preferences.setString(_keyJob, user.job.toString());
  }

  Future<User> getUser() async {
    final _preferences = await SharedPreferences.getInstance();

    final username = await _preferences.getString(_keyUsername);
    final password = await _preferences.getString(_keyPassword);
    final job = await _preferences.getString(_keyJob);

    return User(username, password, job);
  }

}