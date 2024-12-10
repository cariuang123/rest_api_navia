import 'customers_table.dart';
import 'vendors_table.dart';
import 'products_table.dart';
import 'orders_table.dart';
import 'orderitems_table.dart';
import 'productnotes_table.dart';

void main() async {
  final customersMigration = CustomersTableMigration();
  final vendorsMigration = VendorsTableMigration();
  final productsMigration = ProductsTableMigration();
  final ordersMigration = OrdersTableMigration();
  final orderItemsMigration = OrderItemsTableMigration();
  final productNotesMigration = ProductNotesTableMigration();

  // Run migrations
  await customersMigration.up();
  await vendorsMigration.up();
  await productsMigration.up();
  await ordersMigration.up();
  await orderItemsMigration.up();
  await productNotesMigration.up();

  print("All migrations have been successfully executed!");
}
