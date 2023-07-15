import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class FilePickerProvider {
  Future<XFile?> pickOneImage();
}

@Injectable(as: FilePickerProvider)
class FilePickerProviderImpl implements FilePickerProvider {
  @override
  Future<XFile?> pickOneImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      return image;
    } else {
      return null;
    }
  }
}
