import 'package:bookia_store/features/Authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  AuthLocalDataSourceImpl(this.secureStorage);

  final String _tokenKey = 'USER_TOKEN';

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value:token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
  }

}