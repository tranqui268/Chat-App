import 'dart:convert';

import 'package:chat_app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:5000/api/auth';

  Future<UserModel> login({required String email, required String password}) async{
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'email':email, 'password':password}),
      headers: {'Content-Type':'application/json'}

    );

    return UserModel.fromJson(jsonDecode(response.body)['data']);

  }

    Future<UserModel> register({required String email, required String password, required String name}) async{
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({'email':email, 'password':password, 'name':name}),
      headers: {'Content-Type':'application/json'}

    );

    print(response.body);

    return UserModel.fromJson(jsonDecode(response.body)['data']);

  }


}