import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavItem { home, occupants, myHostel, wallet, account }

class BottomNavCubit extends Cubit<BottomNavItem> {
  BottomNavCubit() : super(BottomNavItem.home);

  void selectItem(BottomNavItem item) {
    emit(item);
  }
}
