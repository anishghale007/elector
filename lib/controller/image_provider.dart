import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider =
    ChangeNotifierProvider.autoDispose((ref) => ImageProvider());

class ImageProvider extends ChangeNotifier {
  XFile? image;

  void getImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    image = await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}
