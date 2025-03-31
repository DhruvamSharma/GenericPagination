import 'package:equatable/equatable.dart';
import 'package:pagination_starter/core/color_generator.dart';

// This is how the model will look like
class Product extends Equatable {
  const Product({required this.id, required this.name, required this.image});
  factory Product.fromInteger(int index) {
    final randomColorHexCode = ColorGenerator.generateColor(index).toHex();
    return Product(
      id: index.toString(),
      name: 'Item number: $index',
      image: 'https://dummyjson.com/image/400x200/${randomColorHexCode}/?type=webp&text=With+Id+$index&fontFamily=pacifico',
    );
  }
  final String id;
  final String name;
  final String image;

  @override
  List<Object?> get props => [id];
}

class ProductResponse extends Equatable {
  const ProductResponse({required this.products, required this.time});
  final List<Product> products;
  final DateTime time;

  @override
  List<Object?> get props => [products, time];
}
