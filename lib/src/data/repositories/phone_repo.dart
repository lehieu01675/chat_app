import 'package:chatapp/src/data/providers/remote/phone_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class PhoneRepository {
  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId) pushToOtp,
  });

  Future<void> verifyOTP({
    required String verificationId,
    required String smsCode,
    required void Function()? onError,
  });
}

@Injectable(as: PhoneRepository)
class PhoneRepositoryImpl implements PhoneRepository {
  final PhoneProvider _phoneProvider = GetIt.I.get<PhoneProvider>();

  @override
  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId) pushToOtp,
  }) async {
    await _phoneProvider.sendOtp(
      phoneNumber: phoneNumber,
      pushToOtp: pushToOtp,
    );
  }

  @override
  Future<void> verifyOTP({
    required String verificationId,
    required String smsCode,
    required void Function()? onError,
  }) async {
    await _phoneProvider.verifyOTP(
      verificationId: verificationId,
      smsCode: smsCode,
      onError: onError,
    );
  }
}
