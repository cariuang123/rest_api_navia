import '../../config/database.dart';

class ProductsTableMigration {
  Future<void> up() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('''
      CREATE TABLE IF NOT EXISTS products (
        prod_id VARCHAR(10) PRIMARY KEY,
        vend_id CHAR(5),
        prod_name VARCHAR(25),
        prod_price INT,
        prod_desc TEXT,
        FOREIGN KEY (vend_id) REFERENCES vendors(vend_id)
      )
    ''');
    
    print("Products table created successfully!");
  }

  Future<void> down() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('DROP TABLE IF EXISTS products');
    
    print("Products table dropped successfully!");
  }
}
