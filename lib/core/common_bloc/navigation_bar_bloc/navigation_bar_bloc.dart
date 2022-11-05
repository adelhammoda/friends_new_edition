
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
   int animateIndex = 0;


  NavigationBarBloc() : super(NavigationBarInitial()) {
    on<NavigationBarEvent>((event, emit) {
      if(event is Animate){
        animateIndex = event.index;
        emit(AnimateState(event.index));
      }
      if(state is NavigationBarInitial ){
        animateIndex =0;
        emit(AnimateState(2));
      }
    });
  }
}
