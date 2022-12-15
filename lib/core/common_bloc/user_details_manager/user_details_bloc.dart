import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/use_cases/get_user_info_use_case.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final GetUserInfoUseCase getUserInfo;

  UserDetailsBloc({required this.getUserInfo}) : super(UserDetailsInitial()) {
    on<UserDetailsEvent>((event, emit) async {
      if (event is LoadUserDetailsEvent) {
        if (event.userId.isNullOrEmpty()) {
          emit(const ErrorUserDetailsState(failure: NoDataFailure()));
        } else {
          emit(LoadingUserDetailsState());
          final res = await getUserInfo(userId: event.userId!);
          res.fold(
                  (failure) => emit(ErrorUserDetailsState(failure: failure)),
                  (userEntity) =>
                  emit(LoadedUserDetailsState(userEntity: userEntity)));
        }
      } else {
        emit(UserDetailsInitial());
      }
    });
  }
}
