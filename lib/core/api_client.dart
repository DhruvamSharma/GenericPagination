import 'package:pagination_starter/core/models.dart';

class ApiClient {
  Future<ProductResponse> getProducts({int? page, int pageSize = 10}) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final start = ((page ?? 1) - 1) * pageSize + 1;
    return ProductResponse(
      products: List.generate(
        pageSize,
        (index) {
          return Product.fromInteger(start + index);
        },
      ),
      time: DateTime.now(),
    );
  }
}
