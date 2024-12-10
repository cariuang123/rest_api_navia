import '../../config/database.dart';

class OrdersTableMigration {
  Future<void> up() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('''
      CREATE TABLE IF NOT EXISTS orders (
        order_num INT PRIMARY KEY,
        order_date DATE,
        cust_id CHAR(5),
        FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
      )
    ''');
    
    print("Orders table created successfully!");
  }

  Future<void> down() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('DROP TABLE IF EXISTS orders');
    
    print("Orders table dropped successfully!");
  }
}
