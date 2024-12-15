import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StorageService {
  final String cloudName =
      'dkt9xr8lo'; // Replace with your Cloudinary Cloud Name
  final String uploadPreset =
      'preset-for-file-upload'; // Replace with your Cloudinary Upload Preset

  // TO UPLOAD IMAGE TO CLOUDINARY
  Future<String?> uploadImage(String path, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Uploading image...")));
    print("Uploading image...");
    File file = File(path);

    try {
      // Create the Cloudinary API URL
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

      // Prepare the request
      var request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      // Send the request
      var response = await request.send();

      // Check the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var responseData = jsonDecode(responseBody);
        String downloadURL = responseData['secure_url'];
        print("Download URL: $downloadURL");
        return downloadURL;
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("There was an error uploading to Cloudinary.");
      print(e);
      return null;
    }
  }
}
