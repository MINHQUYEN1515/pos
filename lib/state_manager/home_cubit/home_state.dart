import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final Screen screen;
  const HomeState(
      {this.status = LoadStatus.initial, this.screen = Screen.restaurent});
  @override
  List<Object?> get props => [status, screen];

  HomeState copyWith({LoadStatus? status, Screen? screen}) {
    return HomeState(
        status: status ?? this.status, screen: screen ?? this.screen);
  }
}
