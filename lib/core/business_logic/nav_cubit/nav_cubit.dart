import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavInitial());
   int currentIndex=0;
  void changeScreen({required int index}){
  currentIndex =index ;
    switch(currentIndex){
      case 1:
        emit(NavCalendar());
        break;
      case 2:
        emit(NavAdd());
        break;
      case 3:
        emit(NavNotification());
        break;
      case 4:
        emit(NavProfile());
        break;
      default:
        emit(NavInitial());
    }
  }
}
