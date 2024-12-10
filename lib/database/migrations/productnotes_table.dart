import '../../config/database.dart';

class ProductNotesTableMigration {
  Future<void> up() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('''
      CREATE TABLE IF NOT EXISTS productnotes (
        note_id CHAR(5) PRIMARY KEY,
        prod_id VARCHAR(10),
        note_date DATE,
        note_text TEXT,
        FOREIGN KEY (prod_id) REFERENCES products(prod_id)
      )
    ''');
    
    print("ProductNotes table created successfully!");
  }

  Future<void> down() async {
    final conn = await DatabaseConfig.getConnection();
    
    await conn.query('DROP TABLE IF EXISTS productnotes');
    
    print("ProductNotes table dropped successfully!");
  }
}
