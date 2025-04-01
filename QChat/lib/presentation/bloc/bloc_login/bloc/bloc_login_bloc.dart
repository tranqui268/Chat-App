import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_login_event.dart';
part 'bloc_login_state.dart';

class BlocLoginBloc extends Bloc<BlocLoginEvent, BlocLoginState> {
  BlocLoginBloc() : super(BlocLoginInitial()) {
    on<BlocLoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
