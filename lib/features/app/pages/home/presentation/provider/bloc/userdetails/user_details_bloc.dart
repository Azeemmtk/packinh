import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:packinh/core/model/user_model.dart';
import 'package:packinh/features/app/pages/home/domain/usecases/get_user_details_use_case.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {

  final GetUserDetailsUseCase userDetailsUseCase;

  UserDetailsBloc({required this.userDetailsUseCase}) : super(UserDetailsInitial()) {

    on<FetchUserDetails>(_onFetchUserDetails);
  }


  Future<void> _onFetchUserDetails(FetchUserDetails event, Emitter<UserDetailsState> emit)async{
    emit(UserDetailsLoading());
    final result= await userDetailsUseCase(event.uid);

    result.fold(
        (failure) => emit(UserDetailsError(message: failure.message)),
        (user) => emit(UserDetailsLoaded(user: user)),
    );
  }
}
