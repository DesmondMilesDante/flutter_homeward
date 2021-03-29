import 'package:flutter_homeward/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  String token;

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://60585b2ec3f49200173adcec.mockapi.io/api/v1/login";

    final response = await http.post(url, body: requestModel.toJson());

    print(response.statusCode);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400) {
      token = LoginResponseModel.fromJson(json.decode(response.body)).token;
      print(token);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
