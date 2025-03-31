part of 'pagination_bloc.dart';

class PaginationState<ID, ITEM, E> extends Equatable {
  const PaginationState({
    required this.canLoadMore,
    required this.itemState,
    required this.page,
  });

  factory PaginationState.initial(
    ID id, {
    bool canLoadMore = true,
    DataField<List<ITEM>, E> state = const DataFieldInitial(),
  }) =>
      PaginationState(
        canLoadMore: canLoadMore,
        itemState: state,
        page: id,
      );

  // This variable will hold all the states of initial and future fetches
  final DataField<List<ITEM>, E> itemState;
  final bool canLoadMore;
  // this variable is used to fetch the new batch of items
  // this can be anything from page, last item's id as offset
  // or anything or adjust as you see fit
  final ID page;

  PaginationState<ID, ITEM, E> copyWith({
    ID? page,
    DataField<List<ITEM>, E>? itemState,
    bool? canLoadMore,
  }) {
    return PaginationState(
      page: page ?? this.page,
      itemState: itemState ?? this.itemState,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  List<Object?> get props => [page, canLoadMore, itemState];
}
