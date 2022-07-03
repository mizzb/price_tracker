import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:web_socket_channel/io.dart';
import '../../models/ticks.dart';
import '../../models/active_symbol_response.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

enum StoreState { loading, loaded }

abstract class HomeStoreBase with Store {
  HomeStoreBase();

  @observable
  ActiveSymbolResponse? activeSymbolResponse;

  @observable
  ActiveSymbol? selectedMarket;

  @observable
  String? selectedSymbol;

  @observable
  Ticks? ticks;

  @observable
  Ticks? prevTicks;

  var _marketChannel;
  var _ticksChannel;

  ObservableFuture<ActiveSymbolResponse>? _activeSymbolResponseFuture;

  @computed
  StoreState get state {
    if (_activeSymbolResponseFuture != null &&
        _activeSymbolResponseFuture!.status == FutureStatus.pending) {
      return StoreState.loading;
    } else {
      return StoreState.loaded;
    }
  }

  @action
  getActiveSymbols() {
    _marketChannel = IOWebSocketChannel.connect(
        Uri.parse('wss://ws.binaryws.com/websockets/v3?l=EN&app_id=32314'));

    _marketChannel.sink
        .add(json.encode({'active_symbols': 'brief', 'product_type': 'basic'}));

    _marketChannel.stream.listen(
      (dynamic message) async {
        if (message != null) {
          _activeSymbolResponseFuture = ObservableFuture(
              Future<ActiveSymbolResponse>(() async =>
                  ActiveSymbolResponse.fromJson(jsonDecode(message))));
          activeSymbolResponse = await _activeSymbolResponseFuture;
        }
      },
      onDone: () {
        debugPrint('ws channel closed');
      },
      onError: (error) {
        debugPrint('ws error $error');
      },
    );
  }

  @action
  getTicks() {
    _ticksChannel = IOWebSocketChannel.connect(
        Uri.parse('wss://ws.binaryws.com/websockets/v3?l=EN&app_id=32314'));
    _ticksChannel.sink
        .add(json.encode({"ticks": selectedSymbol, "subscribe": 1}));
    _ticksChannel.stream.listen(
      (dynamic message) async {
        if (message != null) {
          (ticks != null)
              ? prevTicks = ticks
              : Ticks.fromJson(jsonDecode(message));
          ticks = Ticks.fromJson(jsonDecode(message));
        }
      },
      onDone: () {
        debugPrint('ws channel closed');
      },
      onError: (error) {
        debugPrint('ws error $error');
      },
    );
  }

  @action
  closeTicks() {
    if (ticks != null && ticks!.tick != null) {
      _ticksChannel.sink.add(json.encode({"forget_all": "ticks"}));
    }
  }
}
