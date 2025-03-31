part of 'pagination_bloc.dart';

// Base event for triggering pagination fetches.
// The ID refers to the current page, or last item id
sealed class PaginationEvent<ID> extends Equatable {
  const PaginationEvent();

  @override
  List<Object?> get props => [];
}

class PaginateFetchEvent<ID> extends PaginationEvent<ID> {
  const PaginateFetchEvent(this.id);
  final ID id;

  @override
  List<Object?> get props => [id];
}
