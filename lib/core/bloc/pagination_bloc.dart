import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination_starter/core/data_field.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

abstract class PaginationBloc<ID, ITEM, E>
    extends Bloc<PaginationEvent<ID>, PaginationState<ID, ITEM, E>> {

  PaginationBloc({required ID page}) : super(PaginationState.initial(page)) {
    on<PaginateFetchEvent<ID>>((event, emit) async {
       // check if it is already loading, if it is, return
    if (state.itemState is DataFieldLoading) return;
    // check if we can load more results
    if (!state.canLoadMore) return;

    final fetchedProducts = switch (state.itemState) {
      DataFieldInitial<List<ITEM>, E>() => <ITEM>[],
      DataFieldLoading<List<ITEM>, E>(:final data) => data,
      DataFieldSuccess<List<ITEM>, E>(:final data) => data,
      DataFieldError<List<ITEM>, E>(:final data) => data,
    };

    // start loading state
    emit(
      state.copyWith(
        itemState: DataFieldLoading<List<ITEM>, E>(fetchedProducts),
      ),
    );

    // fetch results
    final results = await fetchNext(page: event.id);
    // check if products are returned empty
    // if they are, stop pagination
    if (results.$1.isEmpty) {
      emit(
        state.copyWith(
          canLoadMore: false,
        ),
      );
    }

    final products = [...fetchedProducts, ...results.$1];

    // increment the page number and update data
    emit(
      state.copyWith(
        page: event.id,
        itemState: DataFieldSuccess(products),
      ),
    );
    });
  }
  // Abstract method to fetch the next page of data. This is where the
  // data-specific logic goes.  The BLoC doesn't know *how* to fetch the data,
  // it just knows *when* to fetch it.
  FutureOr<(List<ITEM>, E?)> fetchNext({ID? page});
}
