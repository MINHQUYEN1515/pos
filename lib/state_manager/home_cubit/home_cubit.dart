import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/state_manager/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
}
