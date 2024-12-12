import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samplevarun/homescreen.dart';
import 'package:samplevarun/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/getallfriendsmodel.dart';
import '../model/userloginmodel.dart';
import '../util/base_url.dart';
import '../util/custome_pop_up.dart';

class ImageUpload {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageRepo({required ImageSource source,required int id}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print('image file${_image}');
      if (_image == null) {
        print("No image selected.");
        return;
      }
      final uri = Uri.parse(
          '${StaticUrl.userUpdateUrl}$id'); // Replace with your API endpoint.
      print(uri);
      final request = http.MultipartRequest('PATCH', uri);
      request.files.add(
          await http.MultipartFile.fromPath('profile_image', _image!.path));
      // request.fields['bio'] = "Madhu ";
      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          print('Image uploaded successfully!');
          final responseBody = await response.stream.bytesToString();
          print('Response: $responseBody');
        } else {
          print('Image upload failed. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
}
