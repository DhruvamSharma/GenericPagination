import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:pagination_starter/core/api_client.dart';
import 'package:pagination_starter/core/bloc/pagination_bloc.dart';
import 'package:pagination_starter/core/data_field.dart';
import 'package:pagination_starter/core/models.dart';

part 'product_event.dart';
part 'products_state.dart';

class ProductsBloc extends PaginationBloc<int, Product, String> {
  ProductsBloc(this.apiClient) : super(page: 1);
  final ApiClient apiClient;

  @override
  FutureOr<(List<Product>, String?)> fetchNext({int? page}) async {
    // define: how to parse the products
    return ((await apiClient.getProducts(page: page)).products, null);
  }
}
