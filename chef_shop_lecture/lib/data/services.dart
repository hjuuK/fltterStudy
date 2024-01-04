import 'package:chef_shop_lecture/model/product_model.dart';
import 'package:http/http.dart' as http;

class Services{
  static var client = http.Client();
      // static으로 지정한 이유 : 서버를 열고 닫을때마다 매번 http 클라이언트 생성하는 것은 상당히 비효율적이기 때문

  static Future<List<Product>?> fetchProducts() async { // Product 타입의 Future 리스트는 null값을 가질 수 없음
    var response = await client.get(Uri.parse('https://makeup-api.herokuapp.com'
        '/api/v1/products.json?brand=maybelline'));

    if(response.statusCode == 200) {
      var jasonData = response.body;
      return productFromJson(jasonData);
    }else{
      return null;
    }
  }
}