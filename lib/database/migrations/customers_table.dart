import '../../config/database.dart';

class CustomersTableMigration {
  Future<void> up() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('''
      CREATE TABLE IF NOT EXISTS customers (
        cust_id CHAR(5) PRIMARY KEY,
        cust_name VARCHAR(50),
        cust_address VARCHAR(50),
        cust_city VARCHAR(20),
        cust_state VARCHAR(5),
        cust_zip VARCHAR(7),
        cust_country VARCHAR(50),
        cust_telp VARCHAR(15)
      )
    ''');
    
    print("Customers table created successfully!");
  }

  Future<void> down() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('DROP TABLE IF EXISTS customers');
    
    print("Customers table dropped successfully!");
  }
}
