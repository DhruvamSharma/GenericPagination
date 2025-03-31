import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_starter/core/api_client.dart';
import 'package:pagination_starter/core/bloc/pagination_bloc.dart';
import 'package:pagination_starter/core/bottom_end_scroll_mixin.dart';
import 'package:pagination_starter/core/data_field.dart';
import 'package:pagination_starter/core/models.dart';
import 'package:pagination_starter/counter/bloc/products_bloc.dart';
import 'package:pagination_starter/l10n/l10n.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductsBloc(ApiClient())..add(const PaginateFetchEvent<int>(1)),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> with BottomEndScrollMixin {

  @override
  void initState() {
    // set scroll offset in pixels before which scroll should happen
    paginationOffset = 200;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bloc = context.read<ProductsBloc>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          onScroll(
            notification,
            onEndReached: () {
              // send a call to fetch the new set of items
              bloc.add(PaginateFetchEvent(bloc.state.page + 1));
            },
          );
          return false;
        },
        child: BlocBuilder<ProductsBloc, PaginationState<int, Product, String>>(
          builder: (context, state) {
            return Center(
              child: switch (state.itemState) {
                DataFieldInitial<List<Product>, String>() =>
                  const CircularProgressIndicator(),
                DataFieldLoading<List<Product>, String>(:final data) =>
                  _list(data, true),
                DataFieldSuccess<List<Product>, String>(:final data) =>
                  data.isEmpty
                      ? const Text('No more products found')
                      : _list(data, false),
                DataFieldError<List<Product>, String>(
                  :final error,
                  :final data
                ) =>
                  data.isEmpty ? Text(error) : _list(data, false),
              },
            );
          },
        ),
      ),
    );
  }

  Widget _list(List<Product> data, bool isPaginating) {
    return ListView.builder(
      itemBuilder: (context, index) => _buildItem(
        isPaginating,
        index == data.length,
        index >= data.length? null: data[index],
      ),
      itemCount: data.length + (isPaginating ? 1 : 0),
    );
  }

  Widget _buildItem(bool isPaginating, bool isLastItem, Product? product) {
    if (isPaginating && isLastItem) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Card(
      child: Column(
        children: [
          Image.network(product!.image),
        ],
      ),
    );
  }
}
