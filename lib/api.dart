import 'package:dio/dio.dart';
import '../model/product.dart';

class API {
  Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var url = 'https://fakestoreapi.com/products';
    var response = await dio.get(url); // sử dụng get thay vì request
    List<Product> ls = [];

    if (response.statusCode == 200) {
      List data = response.data;
      ls = data.map((json) => Product.fromJson(json)).toList();
    } else {
      print('Lỗi khi lấy dữ liệu API');
    }
    return ls;
  }
}

var testAPI = API();
