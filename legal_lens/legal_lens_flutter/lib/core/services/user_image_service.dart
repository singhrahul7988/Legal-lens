import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../main.dart'; // for client global

class UserImageService {
  static final UserImageService _instance = UserImageService._internal();
  factory UserImageService() => _instance;
  UserImageService._internal();

  final ImagePicker _picker = ImagePicker();

  String? _cachedProfileImageUrl;
  String? get profileImageUrl => _cachedProfileImageUrl;

  // Notifier to update UI
  final ValueNotifier<String?> profileImageNotifier = ValueNotifier<String?>(null);

  Future<void> initialize() async {
    try {
      // Auth check removed for unrestricted access
      // if (!client.auth.isAuthenticated) {
      //   _cachedProfileImageUrl = null;
      //   profileImageNotifier.value = null;
      //   return;
      // }
      _cachedProfileImageUrl = await client.userImage.getProfileImageUrl();
      if (_cachedProfileImageUrl != null) {
         // Append timestamp to avoid caching issues on initial load if needed, 
         // but usually we want to cache. 
         // However, if we updated it recently, we want fresh.
         // Let's rely on standard caching unless we just updated.
         profileImageNotifier.value = _cachedProfileImageUrl;
      }
    } catch (e) {
      debugPrint('Failed to fetch profile image: $e');
    }
  }

  Future<bool> uploadProfileImage(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return false;

      // Validate size (max 20MB)
      final length = await image.length();
      if (length > 20 * 1024 * 1024) {
        throw Exception('Image size exceeds 20MB limit');
      }

      // Crop
      // ignore: use_build_context_synchronously
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 80,
        maxWidth: 200,
        maxHeight: 200,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Profile Image',
          ),
          WebUiSettings(
            // ignore: use_build_context_synchronously
            context: context,
          ),
        ],
      );

      if (croppedFile == null) return false;

      final bytes = await File(croppedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);
      // We are compressing to jpg, so mime is image/jpeg
      const mimeType = 'image/jpeg';

      final newUrl = await client.userImage.updateUserImage(base64Image, mimeType);
      
      // Append timestamp to force refresh in UI
      _cachedProfileImageUrl = '$newUrl?t=${DateTime.now().millisecondsSinceEpoch}';
      
      profileImageNotifier.value = _cachedProfileImageUrl;
      return true;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> removeImage() async {
    try {
      await client.userImage.removeUserImage();
      _cachedProfileImageUrl = null;
      profileImageNotifier.value = null;
    } catch (e) {
      debugPrint('Error removing image: $e');
      rethrow;
    }
  }
}
