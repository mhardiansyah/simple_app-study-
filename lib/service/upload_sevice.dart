// ignore_for_file: unused_local_variable, avoid_print, camel_case_types

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class uploadService {
  Future uploadImage(Uint8List imagebytes) async {
    Uri url =
        Uri.parse('https://api.cloudinary.com/v1_1/dulun20eo/image/upload');

    var request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'simple_app_preset'
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        imagebytes, 
        filename: 'image.jpg', 
      ));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var responseString = jsonDecode(responseData);
      print('Response: $responseString');
      return responseString['secure_url']; 
    } else {
      print('Error: ${response.statusCode}');
      return null; 
    }
  }
}
