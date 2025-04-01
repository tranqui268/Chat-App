part of 'bloc_login_bloc.dart';

sealed class BlocLoginState extends Equatable {
  const BlocLoginState();
  
  @override
  List<Object> get props => [];
}

final class BlocLoginInitial extends BlocLoginState {}
