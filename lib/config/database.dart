import 'package:mysql1/mysql1.dart';

class DatabaseConfig {
  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 4306, // Sesuaikan dengan port yang digunakan oleh MySQL
      user: 'project', // Username MySQL Anda
      password: 'CariNasi123', // Password MySQL Anda
      db: 'store_online', // Nama database yang digunakan
      useSSL: false,
    );
    return await MySqlConnection.connect(settings);
  }
}
