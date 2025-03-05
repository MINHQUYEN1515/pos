import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class AppState extends Equatable {
  final LoadStatus status;
  const AppState({this.status = LoadStatus.initial});
  @override
  List<Object?> get props => [status];

  AppState copyWith({LoadStatus? status}) {
    return AppState(status: status ?? this.status);
  }
}
