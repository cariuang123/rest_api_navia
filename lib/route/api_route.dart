import 'package:vania/vania.dart';
import 'package:rest_api/app/http/controllers/customers_api.dart';
import 'package:rest_api/app/http/controllers/orders_api.dart';
import 'package:rest_api/app/http/controllers/orders_item_api.dart';
import 'package:rest_api/app/http/controllers/produk_api.dart';
import 'package:rest_api/app/http/controllers/vendors_api.dart';

class ApiRoute implements Route {
  @override
  void register() {
    // Customers Routes
    Router.get('/customers', CustomersController().index);
    Router.post('/customers', CustomersController().create);
    Router.get('/customers/:id', CustomersController().show);
    Router.put('/customers/:id', CustomersController().update);
    Router.delete('/customers/:id', CustomersController().destroy);

    // Orders Routes
    Router.get('/orders', OrdersController().index);
    Router.post('/orders', OrdersController().create);
    Router.get('/orders/:id', OrdersController().show);
    Router.put('/orders/:id', OrdersController().update);
    Router.delete('/orders/:id', OrdersController().destroy);

    // OrderItems Routes
    Router.get('/orderitems', OrderItemsController().index);
    Router.post('/orderitems', OrderItemsController().create);
    Router.get('/orderitems/:id', OrderItemsController().show);

    // Products Routes
    Router.get('/products', ProductsController().index);
    Router.post('/products', ProductsController().create);
    Router.get('/products/:id', ProductsController().show);

    // Vendors Routes
    Router.get('/vendors', VendorsController().index);
    Router.post('/vendors', VendorsController().create);
    Router.get('/vendors/:id', VendorsController().show);
  }
}