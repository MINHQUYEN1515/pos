import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class SplashState extends Equatable {
  final LoadStatus status;
  const SplashState({this.status = LoadStatus.initial});
  @override
  List<Object?> get props => [status];
  SplashState copyWith({LoadStatus? status}) {
    return SplashState(status: status ?? this.status);
  }
}
