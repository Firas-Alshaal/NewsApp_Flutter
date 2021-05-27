//  COUNTER APP

abstract class CounterState {}

class CounterInitializeState extends CounterState {}

class CounterMinusState extends CounterState {}

class CounterPlusState extends CounterState {}

// NAVIGATION BAR APP

abstract class AppState {}

class AppInitializeState extends AppState {}

class AppChangeBottomNavBarState extends AppState {}

class AppCreateDataBaseState extends AppState {}

class AppInsertDataBaseState extends AppState {}

class AppGetDataBaseState extends AppState {}

class AppGetDataBaseLoadingState extends AppState {}

class AppUpdateDataBaseState extends AppState {}

class AppDeleteDataBaseState extends AppState {}

class AppChangeBottomSheetState extends AppState {}

class AppChangeModeState extends AppState {}
