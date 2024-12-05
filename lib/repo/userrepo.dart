import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userloginmodel.dart';

class UserRepo {
  Future<UserLoginModel?> loginRepo(
      {required String userName, required String password}) async {
    try {
      Uri url = Uri.parse("http://192.168.2.82:8000/chat/login");
      var jsonBody = jsonEncode({"username": userName, "password": password});
      final response = await http.post(url, body: jsonBody, headers: {
        // Add your token here
        'Content-Type': 'application/json', // Content type
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('userName', userName);
        // await prefs.setString('password', password);
        // final getprefs = await SharedPreferences.getInstance();
        // final counter = getprefs.getString('userName') ?? "NA";
        // print("Counter: $counter");
        return UserLoginModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        return UserLoginModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }

    Future<UserLoginModel?> userCreateRepo({
      required String userName,
      required String password,
      String? email,
      required String? firstName,
      required String? lastName,
    }) async {
      try {
        Uri url = Uri.parse("http://192.168.2.82:8000/chat/user");
        var jsonBody = jsonEncode({
          "is_superuser": false,
          "username": userName,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
          "is_staff": true,
          "is_active": true,
          "date_joined": DateTime.now().toString(),
          "groups": [],
          "user_permissions": []
        });
        final response = await http.post(url, body: jsonBody, headers: {
          // Add your token here
          'Content-Type': 'application/json', // Content type
        });
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 201 || response.statusCode == 200) {
          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('userName', userName);
          // await prefs.setString('password', password);
          // final getprefs = await SharedPreferences.getInstance();
          // final counter = getprefs.getString('userName') ?? "NA";
          // print("Counter: $counter");
          return UserLoginModel.fromJson(json.decode(response.body));
        } else if (response.statusCode == 400) {
          return UserLoginModel.fromJson(json.decode(response.body));
        }
      } catch (e) {
        print("error catch $e");
        return null;
      }
    }
  }

  Future<List<Data>> getFriendsListRepo() async {
    List<Data> userdata = [];
    try {
      Uri url = Uri.parse("http://192.168.2.82:8000/chat/getfriends");
      // var jsonBody = jsonEncode({"username": userName, "password": password});
      final response = await http.get(url, headers: {
        // Add your token here
        'Content-Type': 'application/json', // Content type
      });
      print("response.statusCode${response.statusCode}");
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body)['data'] as List;
        userdata = jsonResponse.map((e) => Data.fromJson(e)).toList();
        return userdata;
      } else if (response.statusCode == 400) {
        return userdata;
      } else {
        return userdata;
      }
    } catch (e) {
      print("error catch $e");
      return userdata;
    }
  }

  Future<void> sendMessageRepo(
      {
        required String message,
        required String to_user,
        required String from_user,

      }) async {
    try {
      Uri url = Uri.parse("http://192.168.2.82:8000/chat/sendmessage");
      var jsonBody = jsonEncode({
        "message": message,
        "to_like": false,
        "from_like": false,
        "timestamp": DateTime.now().toString(),
        "from_user": from_user,
        "to_user": to_user
      });
      final response = await http.post(url, body: jsonBody, headers: {
        // Add your token here
        'Content-Type': 'application/json', // Content type
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('userName', userName);
        // await prefs.setString('password', password);
        // final getprefs = await SharedPreferences.getInstance();
        // final counter = getprefs.getString('userName') ?? "NA";
        // print("Counter: $counter");
        // return UserLoginModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        // return UserLoginModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }

    Future<UserLoginModel?> userCreateRepo({
      required String userName,
      required String password,
      String? email,
      required String? firstName,
      required String? lastName,
    }) async {
      try {
        Uri url = Uri.parse("http://192.168.2.82:8000/chat/user");
        var jsonBody = jsonEncode({
          "is_superuser": false,
          "username": userName,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
          "is_staff": true,
          "is_active": true,
          "date_joined": DateTime.now().toString(),
          "groups": [],
          "user_permissions": []
        });
        final response = await http.post(url, body: jsonBody, headers: {
          // Add your token here
          'Content-Type': 'application/json', // Content type
        });
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 201 || response.statusCode == 200) {
          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('userName', userName);
          // await prefs.setString('password', password);
          // final getprefs = await SharedPreferences.getInstance();
          // final counter = getprefs.getString('userName') ?? "NA";
          // print("Counter: $counter");
          return UserLoginModel.fromJson(json.decode(response.body));
        } else if (response.statusCode == 400) {
          return UserLoginModel.fromJson(json.decode(response.body));
        }
      } catch (e) {
        print("error catch $e");
        return null;
      }
    }
  }
}
