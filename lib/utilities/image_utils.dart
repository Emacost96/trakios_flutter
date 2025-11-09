import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImageFromCamera() async {
  final ImagePicker picker = ImagePicker(
  );
  final XFile? photo = await picker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

  if (photo != null) {
    return File(photo.path);
  }
  return null;
}
