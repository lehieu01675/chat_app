import 'package:chatapp/src/data/providers/remote/contact_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class ContactRepository {
  Future<void> deleteContactUser({required String id});

  Future<bool> addChatUser({required String checkID});
}

@Injectable(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  final ContactProvider _contactProvider = GetIt.I.get<ContactProvider>();

  @override
  Future<bool> addChatUser({required String checkID}) async {
    return await _contactProvider.addChatUser(checkID: checkID);
  }

  @override
  Future<void> deleteContactUser({required String id}) async {
    await _contactProvider.deleteContactUser(id: id);
  }
}
