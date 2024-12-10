import 'package:vania/vania.dart';
import '../../../config/database.dart';

class OrderItemsController extends Controller {
  // Menampilkan daftar semua order items
  Future<Response> index() async {
    final conn = await DatabaseConfig.getConnection();
    final results = await conn.query('SELECT * FROM orderitems');
    
    final orderItems = results.map((row) {
      return {
        'order_item': row[0],
        'order_num': row[1],
        'prod_id': row[2],
        'quantity': row[3],
        'size': row[4],
      };
    }).toList();
    
    return Response.json({
      'message': 'List of order items',
      'data': orderItems,
    });
  }

  // Menambahkan order item baru
  Future<Response> create(Request request) async {
    try {
      final requestData = request.input();
      
      final conn = await DatabaseConfig.getConnection();
      
      await conn.query('''
        INSERT INTO orderitems (order_item, order_num, prod_id, quantity, size)
        VALUES (?, ?, ?, ?, ?)
      ''', [
        requestData['order_item'],
        requestData['order_num'],
        requestData['prod_id'],
        requestData['quantity'],
        requestData['size'],
      ]);
      
      return Response.json({
        "message": "Order item berhasil ditambahkan",
        "data": requestData,
      }, 201);
    } catch (e) {
      return Response.json(
        {
          "message": "Error terjadi pada server, silahkan coba lagi nanti",
        },
        500,
      );
    }
  }

  // Menampilkan detail order item berdasarkan order_item
  Future<Response> show(Request request, String id) async {
    final conn = await DatabaseConfig.getConnection();
    final result = await conn.query('SELECT * FROM orderitems WHERE order_item = ?', [id]);
    
    if (result.isEmpty) {
      return Response.json(
        {'message': 'Order item not found'},
        404,
      );
    }

    final row = result.first;
    final orderItem = {
      'order_item': row[0],
      'order_num': row[1],
      'prod_id': row[2],
      'quantity': row[3],
      'size': row[4],
    };

    return Response.json(orderItem);
  }
}
