part of 'products_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState({
    required this.page,
    required this.products,
    required this.canLoadMore,
  });
  factory ProductsState.initial() => const ProductsState(
        // page is always incremented when
        // it's sent, so starting from 0.
        page: 0,
        products: DataFieldInitial(),
        canLoadMore: true,
      );
  final int page;
  final DataField<List<Product>, String> products;
  final bool canLoadMore;

  ProductsState copyWith({
    int? page,
    DataField<List<Product>, String>? products,
    bool? canLoadMore,
  }) {
    return ProductsState(
      page: page ?? this.page,
      products: products ?? this.products,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  List<Object?> get props => [products, page, canLoadMore];
}
