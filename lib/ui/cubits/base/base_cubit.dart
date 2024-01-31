import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
We will user BLoC for managing api calling and states while calling api
This is Base for cubit classes which has 2 parameter S and T.
S stands for state and T for data
*/

class BaseCubit<S, T> extends Cubit<S> {
  BaseCubit(S initialState, this._data) : super(initialState);
  T _data;

  @protected
  T get data => _data;

  bool _isBusy = false;

  //This field let us know that cubit is busy or not for api calling
  bool get isBusy => _isBusy;

  /*
  Run method will mark cubit as busy while processing its request
  We pass function in run method which will be api calling
  */
  @protected
  Future<void> run(Future<void> Function() process) async {
    if (!_isBusy) {
      _isBusy = true;
      await process();
      _isBusy = false;
    }
  }
}
