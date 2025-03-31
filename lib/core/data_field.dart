import 'package:equatable/equatable.dart';
// T is type of data
// H is type of error
sealed class DataField<T,H> extends Equatable {
  const DataField();
}

class DataFieldInitial<T, H> extends DataField<T, H> {
  const DataFieldInitial();
  @override
  List<Object?> get props => [];
}
class DataFieldLoading<T, H> extends DataField<T, H> {
  const DataFieldLoading(this.data);
  final T data;

  @override
  List<Object?> get props => [data];
}
class DataFieldSuccess<T, H> extends DataField<T, H> {
  const DataFieldSuccess(this.data);
  final T data;

  @override
  List<Object?> get props => [data];
}

class DataFieldError<T, H> extends DataField<T, H> {
  const DataFieldError(this.error, this.data);
  final H error;
  final T data;

  @override
  List<Object?> get props => [error, data];
}
