import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductRepository {
  final DioClient _dioClient = DioClient();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dioClient.get(
        'https://fakestoreapi.com/products',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      rethrow;
    }
  }
}
