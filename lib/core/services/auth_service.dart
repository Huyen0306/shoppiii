import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/models/user_model.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  String? _token;
  int? _userId;
  bool _isAuthenticated = false;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  int? get userId => _userId;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> init() async {
    await loadAuthState();
  }

  Future<void> loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    final int? userId = prefs.getInt('user_id');

    if (token != null && userId != null) {
      _token = token;
      _userId = userId;
      _isAuthenticated = true;
      // User info will be loaded when needed
      notifyListeners();
    }
  }

  Future<void> login(String token, int userId) async {
    _token = token;
    _userId = userId;
    _isAuthenticated = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setInt('user_id', userId);
    notifyListeners();
  }

  Future<void> setUser(UserModel user) async {
    _currentUser = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    _isAuthenticated = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    notifyListeners();
  }
}

