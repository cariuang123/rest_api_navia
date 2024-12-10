import 'package:vania/vania.dart';
import '../../../config/database.dart';

class OrdersController extends Controller {
  // Menampilkan daftar semua order
  Future<Response> index() async {
    final conn = await DatabaseConfig.getConnection();
    final results = await conn.query('SELECT * FROM orders');
    
    final orders = results.map((row) {
      return {
        'order_num': row[0],
        'order_date': row[1],
        'cust_id': row[2],
      };
    }).toList();
    
    return Response.json({
      'message': 'List of orders',
      'data': orders,
    });
  }

  // Menambahkan order baru
  Future<Response> create(Request request) async {
    try {
      final requestData = request.input();
      
      final conn = await DatabaseConfig.getConnection();
      
      await conn.query('''
        INSERT INTO orders (order_num, order_date, cust_id)
        VALUES (?, ?, ?)
      ''', [
        requestData['order_num'],
        requestData['order_date'],
        requestData['cust_id'],
      ]);
      
      return Response.json({
        "message": "Order berhasil ditambahkan",
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

  // Menampilkan detail order berdasarkan order_num
  Future<Response> show(Request request, String id) async {
    final conn = await DatabaseConfig.getConnection();
    final result = await conn.query('SELECT * FROM orders WHERE order_num = ?', [id]);
    
    if (result.isEmpty) {
      return Response.json(
        {'message': 'Order not found'},
        404,
      );
    }

    final row = result.first;
    final order = {
      'order_num': row[0],
      'order_date': row[1],
      'cust_id': row[2],
    };

    return Response.json(order);
  }

  // Memperbarui order berdasarkan order_num
  Future<Response> update(Request request, String id) async {
    try {
      final requestData = request.input();
      final conn = await DatabaseConfig.getConnection();
      
      final result = await conn.query('''
        UPDATE orders
        SET order_date = ?, cust_id = ?
        WHERE order_num = ?
      ''', [
        requestData['order_date'],
        requestData['cust_id'],
        id,
      ]);
      
      if (result.affectedRows == 0) {
        return Response.json({'message': 'Order not found'}, 404);
      }
      
      return Response.json({
        "message": "Order berhasil diperbarui",
        "data": requestData,
      });
    } catch (e) {
      return Response.json(
        {'message': 'Error terjadi pada server, silahkan coba lagi nanti'},
        500,
      );
    }
  }

  // Menghapus order berdasarkan order_num
  Future<Response> destroy(Request request, String id) async {
    try {
      final conn = await DatabaseConfig.getConnection();
      final result = await conn.query('DELETE FROM orders WHERE order_num = ?', [id]);
      
      if (result.affectedRows == 0) {
        return Response.json({'message': 'Order not found'}, 404);
      }

      return Response.json({
        "message": "Order berhasil dihapus",
      });
    } catch (e) {
      return Response.json(
        {'message': 'Error terjadi pada server, silahkan coba lagi nanti'},
        500,
      );
    }
  }
}
