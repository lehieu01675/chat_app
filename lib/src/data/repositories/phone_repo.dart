import 'package:chatapp/src/data/providers/remote/phone_provider.dart';

class PhoneRepository {
  final PhoneProvider _phoneProvider = PhoneProvider();

  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId) pushToOtp,
  }) async {
    await _phoneProvider.sendOtp(
      phoneNumber: phoneNumber,
      pushToOtp: pushToOtp,
    );
  }

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
