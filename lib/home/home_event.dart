import 'dart:async';
import 'package:devfest_gandhinagar/home/home_provider.dart';
import 'package:devfest_gandhinagar/home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  final IHomeProvider _homeProvider = HomeProvider();
  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      var res = await _homeProvider.getSpeakers();
      return InHomeState(speakersData: res);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorHomeState(_?.toString());
    }
  }
}
