import 'package:vania/vania.dart';
import '../../../config/database.dart';

class ProductsController extends Controller {
  // Menampilkan daftar semua produk
  Future<Response> index() async {
    final conn = await DatabaseConfig.getConnection();
    final results = await conn.query('SELECT * FROM products');
    
    final products = results.map((row) {
      return {
        'prod_id': row[0],
        'prod_name': row[1],
        'prod_desc': row[2],
        'prod_price': row[3],
      };
    }).toList();
    
    return Response.json({
      'message': 'List of products',
      'data': products,
    });
  }

  // Menambahkan produk baru
  Future<Response> create(Request request) async {
    try {
      final requestData = request.input();
      
      final conn = await DatabaseConfig.getConnection();
      
      await conn.query('''
        INSERT INTO products (prod_id, prod_name, prod_desc, prod_price)
        VALUES (?, ?, ?, ?)
      ''', [
        requestData['prod_id'],
        requestData['prod_name'],
        requestData['prod_desc'],
        requestData['prod_price'],
      ]);
      
      return Response.json({
        "message": "Product berhasil ditambahkan",
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

  // Menampilkan detail produk berdasarkan prod_id
  Future<Response> show(Request request, String id) async {
    final conn = await DatabaseConfig.getConnection();
    final result = await conn.query('SELECT * FROM products WHERE prod_id = ?', [id]);
    
    if (result.isEmpty) {
      return Response.json(
        {'message': 'Product not found'},
        404,
      );
    }

    final row = result.first;
    final product = {
      'prod_id': row[0],
      'prod_name': row[1],
      'prod_desc': row[2],
      'prod_price': row[3],
    };

    return Response.json(product);
  }
}
