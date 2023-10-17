import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

extension CropImage on XFile? {
  Future<XFile?> cropImage(
    double ratioX,
    double ratioY, {
    String? title,
    int compressQuality = 60,
  }) async {
    final file = this;
    if (file == null) {
      return null;
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
      compressQuality: compressQuality,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: title ?? 'Crop image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          rotateButtonsHidden: true,
          minimumAspectRatio: 1,
        ),
      ],
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (croppedFile == null) return null;

    return XFile(croppedFile.path);
  }
}
