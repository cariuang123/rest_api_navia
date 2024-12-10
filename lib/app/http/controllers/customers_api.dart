import 'package:vania/vania.dart';
import '../../../config/database.dart';

class CustomersController extends Controller {
  // Menampilkan daftar semua customer
  Future<Response> index() async {
    final conn = await DatabaseConfig.getConnection();
    final results = await conn.query('SELECT * FROM customers');
    
    final customers = results.map((row) {
      return {
        'cust_id': row[0],
        'cust_name': row[1],
        'cust_address': row[2],
        'cust_city': row[3],
        'cust_state': row[4],
        'cust_zip': row[5],
        'cust_country': row[6],
        'cust_telp': row[7],
      };
    }).toList();
    
    return Response.json({
      'message': 'List of customers',
      'data': customers,
    });
  }

  // Menambahkan customer baru
  Future<Response> create(Request request) async {
    try {
      final requestData = request.input();
      
      final conn = await DatabaseConfig.getConnection();
      
      await conn.query('''
        INSERT INTO customers (cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_telp)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      ''', [
        requestData['cust_id'],
        requestData['cust_name'],
        requestData['cust_address'],
        requestData['cust_city'],
        requestData['cust_state'],
        requestData['cust_zip'],
        requestData['cust_country'],
        requestData['cust_telp'],
      ]);
      
      return Response.json({
        "message": "Customer berhasil ditambahkan",
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

  // Menampilkan detail customer berdasarkan ID
  Future<Response> show(Request request, String id) async {
    final conn = await DatabaseConfig.getConnection();
    final result = await conn.query('SELECT * FROM customers WHERE cust_id = ?', [id]);
    
    if (result.isEmpty) {
      return Response.json(
        {'message': 'Customer not found'},
        404,
      );
    }

    final row = result.first;
    final customer = {
      'cust_id': row[0],
      'cust_name': row[1],
      'cust_address': row[2],
      'cust_city': row[3],
      'cust_state': row[4],
      'cust_zip': row[5],
      'cust_country': row[6],
      'cust_telp': row[7],
    };

    return Response.json(customer);
  }

  // Memperbarui data customer berdasarkan ID
  Future<Response> update(Request request, String id) async {
    try {
      final requestData = request.input();
      final conn = await DatabaseConfig.getConnection();
      
      final result = await conn.query('''
        UPDATE customers
        SET cust_name = ?, cust_address = ?, cust_city = ?, cust_state = ?, cust_zip = ?, cust_country = ?, cust_telp = ?
        WHERE cust_id = ?
      ''', [
        requestData['cust_name'], 
        requestData['cust_address'], 
        requestData['cust_city'],
        requestData['cust_state'],
        requestData['cust_zip'],
        requestData['cust_country'],
        requestData['cust_telp'],
        id,
      ]);
      
      if (result.affectedRows == 0) {
        return Response.json({'message': 'Customer not found'}, 404);
      }
      
      return Response.json({
        "message": "Customer berhasil diperbarui",
        "data": requestData,
      });
    } catch (e) {
      return Response.json(
        {'message': 'Error terjadi pada server, silahkan coba lagi nanti'},
        500,
      );
    }
  }

  // Menghapus customer berdasarkan ID
  Future<Response> destroy(Request request, String id) async {
    try {
      final conn = await DatabaseConfig.getConnection();
      final result = await conn.query('DELETE FROM customers WHERE cust_id = ?', [id]);
      
      if (result.affectedRows == 0) {
        return Response.json({'message': 'Customer not found'}, 404);
      }

      return Response.json({
        "message": "Customer berhasil dihapus",
      });
    } catch (e) {
      return Response.json(
        {'message': 'Error terjadi pada server, silahkan coba lagi nanti'},
        500,
      );
    }
  }
}
