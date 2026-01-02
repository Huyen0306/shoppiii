import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import '../models/auth_response.dart';

class UserRepository {
  final DioClient _dioClient = DioClient();

  Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await _dioClient.post(
        'https://fakestoreapi.com/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      // Accept both 200 (OK) and 201 (Created) as success
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUser(int userId) async {
    try {
      final response = await _dioClient.get(
        'https://fakestoreapi.com/users/$userId',
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final response = await _dioClient.get(
        'https://fakestoreapi.com/users',
      );

      if (response.statusCode == 200) {
        final List<dynamic> users = response.data;
        final userJson = users.firstWhere(
          (user) => user['username'] == username,
          orElse: () => null,
        );
        if (userJson != null) {
          return UserModel.fromJson(userJson);
        }
        return null;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      rethrow;
    }
  }
}

