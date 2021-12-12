part of 'detail_tv_bloc.dart';

class DetailTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailTvEvent extends DetailTvEvent {
  final int id;

  GetDetailTvEvent(this.id);

  @override
  List<Object?> get props => [id];
}
