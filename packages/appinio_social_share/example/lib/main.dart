import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appinio_social_share/appinio_social_share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppinioSocialShare appinioSocialShare = AppinioSocialShare();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Share Feature",
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("ShareToWhatsapp"),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: false);
                  if (result != null && result.paths.isNotEmpty) {
                    shareToWhatsApp("message", result.paths[0]!);
                  }
                },
              ),
              ElevatedButton(
                child: const Text("ShareToFacebook"),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: false);
                  if (result != null && result.paths.isNotEmpty) {
                    shareToFacebook("message", result.paths[0]!);
                  }
                },
              ),
            ],
          ),
        ));
  }

  void shareToFacebook(String message, String filePath) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await appinioSocialShare.iOS.shareToFacebook(message, [filePath]);
      return;
    }
    try {
      await appinioSocialShare.android.shareToFacebook(message, [filePath]);
    } catch (e) {
      print('exception: $e');
    }
  }

  void shareToMessenger(String message) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await appinioSocialShare.iOS.shareToMessenger(message);
      return;
    }
    try {
      await appinioSocialShare.android.shareToMessenger(message);
    } catch (e) {
      print('exception: $e');
    }
  }

  shareToWhatsApp(String message, String filePath) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await appinioSocialShare.iOS.shareToSMS(message);
      return;
    }
    await appinioSocialShare.android.shareToSMS(message, filePath);
  }
}
