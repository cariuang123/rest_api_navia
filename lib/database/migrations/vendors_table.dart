import '../../config/database.dart';

class VendorsTableMigration {
  Future<void> up() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('''
      CREATE TABLE IF NOT EXISTS vendors (
        vend_id CHAR(5) PRIMARY KEY,
        vend_name VARCHAR(50),
        vend_address TEXT,
        vend_kota TEXT,
        vend_state VARCHAR(5),
        vend_zip VARCHAR(7),
        vend_country VARCHAR(25)
      )
    ''');
    
    print("Vendors table created successfully!");
  }

  Future<void> down() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('DROP TABLE IF EXISTS vendors');
    
    print("Vendors table dropped successfully!");
  }
}
