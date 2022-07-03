// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??=
          Computed<StoreState>(() => super.state, name: 'HomeStoreBase.state'))
      .value;

  late final _$activeSymbolResponseAtom =
      Atom(name: 'HomeStoreBase.activeSymbolResponse', context: context);

  @override
  ActiveSymbolResponse? get activeSymbolResponse {
    _$activeSymbolResponseAtom.reportRead();
    return super.activeSymbolResponse;
  }

  @override
  set activeSymbolResponse(ActiveSymbolResponse? value) {
    _$activeSymbolResponseAtom.reportWrite(value, super.activeSymbolResponse,
        () {
      super.activeSymbolResponse = value;
    });
  }

  late final _$selectedMarketAtom =
      Atom(name: 'HomeStoreBase.selectedMarket', context: context);

  @override
  ActiveSymbol? get selectedMarket {
    _$selectedMarketAtom.reportRead();
    return super.selectedMarket;
  }

  @override
  set selectedMarket(ActiveSymbol? value) {
    _$selectedMarketAtom.reportWrite(value, super.selectedMarket, () {
      super.selectedMarket = value;
    });
  }

  late final _$selectedSymbolAtom =
      Atom(name: 'HomeStoreBase.selectedSymbol', context: context);

  @override
  String? get selectedSymbol {
    _$selectedSymbolAtom.reportRead();
    return super.selectedSymbol;
  }

  @override
  set selectedSymbol(String? value) {
    _$selectedSymbolAtom.reportWrite(value, super.selectedSymbol, () {
      super.selectedSymbol = value;
    });
  }

  late final _$ticksAtom = Atom(name: 'HomeStoreBase.ticks', context: context);

  @override
  Ticks? get ticks {
    _$ticksAtom.reportRead();
    return super.ticks;
  }

  @override
  set ticks(Ticks? value) {
    _$ticksAtom.reportWrite(value, super.ticks, () {
      super.ticks = value;
    });
  }

  late final _$prevTicksAtom =
      Atom(name: 'HomeStoreBase.prevTicks', context: context);

  @override
  Ticks? get prevTicks {
    _$prevTicksAtom.reportRead();
    return super.prevTicks;
  }

  @override
  set prevTicks(Ticks? value) {
    _$prevTicksAtom.reportWrite(value, super.prevTicks, () {
      super.prevTicks = value;
    });
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic getActiveSymbols() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getActiveSymbols');
    try {
      return super.getActiveSymbols();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getTicks() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getTicks');
    try {
      return super.getTicks();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic closeTicks() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.closeTicks');
    try {
      return super.closeTicks();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activeSymbolResponse: ${activeSymbolResponse},
selectedMarket: ${selectedMarket},
selectedSymbol: ${selectedSymbol},
ticks: ${ticks},
prevTicks: ${prevTicks},
state: ${state}
    ''';
  }
}
