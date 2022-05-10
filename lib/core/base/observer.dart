import 'package:bloc/bloc.dart';

class Observer extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    print('oncreate---${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    print('onEvent---${bloc.runtimeType},$event ');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange

    super.onChange(bloc, change);
    print('onChange---${bloc.runtimeType},$change ');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print('onTransition---${bloc.runtimeType},$transition ');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    print('onEvent---${bloc.runtimeType},$error ');
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    print('onEvent---${bloc.runtimeType}   ');
    super.onClose(bloc);
  }
}
