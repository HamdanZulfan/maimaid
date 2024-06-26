import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<User> fetchUserDetail(String userId) async {
    final response = await _dio.get('https://reqres.in/api/users/$userId');
    if (response.statusCode == 200) {
      return User.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    final response =
        await _dio.put('https://reqres.in/api/users/$userId', data: data);
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('https://reqres.in/api/users?page=1');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Response> createUser(String name, String job) async {
    final response = await _dio.post(
      'https://reqres.in/api/users',
      data: {
        'name': name,
        'job': job,
      },
    );

    return response;
  }

  Future<void> deleteUser(String userId) async {
    final response = await _dio.delete('https://reqres.in/api/users/$userId');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}
