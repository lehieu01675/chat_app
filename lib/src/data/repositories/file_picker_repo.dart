import 'package:chatapp/src/data/providers/local/file_picker_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class FilePickerRepository {
  Future<XFile?> pickOneImage();
}

@Injectable(as: FilePickerRepository)
class FilePickerRepositoryImpl implements FilePickerRepository {
  final FilePickerProvider _filePickerProvider =
      GetIt.I.get<FilePickerProvider>();

  @override
  Future<XFile?> pickOneImage() async {
    return await _filePickerProvider.pickOneImage();
  }
}
