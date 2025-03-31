part of 'products_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProducts extends ProductEvent {
  const GetProducts(this.page);
  final int page;
  @override
  List<Object?> get props => [page];
}