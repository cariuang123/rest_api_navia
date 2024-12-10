import 'package:vania/vania.dart';
import '../../../config/database.dart';

class VendorsController extends Controller {
  // Menampilkan daftar semua vendor
  Future<Response> index() async {
    final conn = await DatabaseConfig.getConnection();
    final results = await conn.query('SELECT * FROM vendors');
    
    final vendors = results.map((row) {
      return {
        'vend_id': row[0],
        'vend_name': row[1],
        'vend_address': row[2],
        'vend_kota': row[3],
        'vend_state': row[4],
        'vend_zip': row[5],
        'vend_country': row[6],
      };
    }).toList();
    
    return Response.json({
      'message': 'List of vendors',
      'data': vendors,
    });
  }

  // Menambahkan vendor baru
  Future<Response> create(Request request) async {
    try {
      final requestData = request.input();
      
      final conn = await DatabaseConfig.getConnection();
      
      await conn.query('''
        INSERT INTO vendors (vend_id, vend_name, vend_address, vend_kota, vend_state, vend_zip, vend_country)
        VALUES (?, ?, ?, ?, ?, ?, ?)
      ''', [
        requestData['vend_id'],
        requestData['vend_name'],
        requestData['vend_address'],
        requestData['vend_kota'],
        requestData['vend_state'],
        requestData['vend_zip'],
        requestData['vend_country'],
      ]);
      
      return Response.json({
        "message": "Vendor berhasil ditambahkan",
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

  // Menampilkan detail vendor berdasarkan vend_id
  Future<Response> show(Request request, String id) async {
    final conn = await DatabaseConfig.getConnection();
    final result = await conn.query('SELECT * FROM vendors WHERE vend_id = ?', [id]);
    
    if (result.isEmpty) {
      return Response.json(
        {'message': 'Vendor not found'},
        404,
      );
    }

    final row = result.first;
    final vendor = {
      'vend_id': row[0],
      'vend_name': row[1],
      'vend_address': row[2],
      'vend_kota': row[3],
      'vend_state': row[4],
      'vend_zip': row[5],
      'vend_country': row[6],
    };

    return Response.json(vendor);
  }
}
