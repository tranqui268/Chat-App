import 'dart:convert';

import 'package:chat_app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSource{
  final String baseUrl = "http://10.0.2.2:5000/api/auth/find/user";

  Future<UserModel> getUserById(String userId) async{
    try {
       final response = await http.get(
        Uri.parse('$baseUrl/$userId'),
        headers: {'Content-Type': 'application/json'},
       );

       if (response.statusCode == 200) {
        print(response.body);
         return UserModel.fromJson(jsonDecode(response.body)['user']);
       }else{
        throw Exception('Failed to get user: ${response.statusCode} - ${response.body}');
       }
    } catch (e) {
      throw Exception('Error fetching user: $e'); 
    }
  }
}