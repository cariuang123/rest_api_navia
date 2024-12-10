import '../../config/database.dart';

class OrderItemsTableMigration {
  Future<void> up() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('''
      CREATE TABLE IF NOT EXISTS orderitems (
        order_item INT PRIMARY KEY,
        order_num INT,
        prod_id VARCHAR(10),
        quantity INT,
        size INT,
        FOREIGN KEY (order_num) REFERENCES orders(order_num),
        FOREIGN KEY (prod_id) REFERENCES products(prod_id)
      )
    ''');
    
    print("OrderItems table created successfully!");
  }

  Future<void> down() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('DROP TABLE IF EXISTS orderitems');
    
    print("OrderItems table dropped successfully!");
  }
}
