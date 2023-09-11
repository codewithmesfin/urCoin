import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urcoin/sqlite/user.db.service.dart';

class AuthProvider with ChangeNotifier {
  late String _currentUserId = '';
  late bool _isLoading = false;
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _phoneNumber = "";
  String _password = "";
  String _id = "";
  String? _token;

  // Getters
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get password => _password;
  String get id => _id;
  String? get token => _token;

  bool get isLoading => _isLoading;
  String get currentUserId => _currentUserId;
  late bool _showPassword = false;
  bool get showPassword => _showPassword;

  // Setters
  void setPasswordVisible(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setId(String value) {
    _id = value;
    notifyListeners();
  }

  void setToken(String? value) {
    _token = value;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> signIn() async {
    try {
      final user = await UserDatabaseHelper.signIn(_email, _password);

      Object? id = user[0]['id'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', "$id");
      return user.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp() async {
    final currentTime = DateTime.now().microsecondsSinceEpoch;
    final user = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'createdAt': currentTime,
      'updatedAt': currentTime
    };
    try {
      await UserDatabaseHelper.createItem(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> authentiacted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    _currentUserId = token;
    return token.isNotEmpty;
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    _currentUserId = token;
    return token;
  }
}
