import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seventh_chat_app/bloc/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      // addError(Exception('increment error!'), StackTrace.current);
      emit(state + 1);
    });
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change); // Change { currentState: 0, nextState: 1 }
  }

// Note: onTransition is invoked before onChange and contains the event which triggered the change from currentState to nextState.
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    // Transition { currentState: 0, event: Instance of 'CounterIncrementPressed', nextState: 1 }
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error $stackTrace');
    super.onError(error, stackTrace);
  }
}
