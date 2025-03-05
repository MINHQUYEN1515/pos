import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  const HomeState({this.status = LoadStatus.initial});
  @override
  List<Object?> get props => [status];

  HomeState copyWith({LoadStatus? status}) {
    return HomeState(status: status ?? this.status);
  }
}
