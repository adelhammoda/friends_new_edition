import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/home_page/domain/use_cases/get_current_user.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final GetCurrentUserUseCases getCurrentUserUseCases;

  HomepageBloc({required this.getCurrentUserUseCases})
      : super(HomepageInitial()) {
    on<HomepageEvent>((event, emit) async{
     switch(event.runtimeType){
       case LoadUserEvent:
         {
           Either<Failure,UserEntity> res =await getCurrentUserUseCases();
           res.fold((failure) {
             if(failure.statusCode != StatusCode.userNotFound){
               emit(UserNotLoadedState());
             }
           }, (user) {
             if(user.user == ConstantManager.centerType){
               emit(CenterState(user));
             }else {
               emit(StudentState(user));
             }
           });
         }
     }
    });
  }
}
