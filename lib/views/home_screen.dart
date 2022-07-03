import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:price_tracker/controller/stores/home_store.dart';
import 'package:price_tracker/widgets/deriv_market_text.dart';
import 'package:price_tracker/widgets/lottie_widget.dart';

import '../injector.dart';
import '../models/active_symbol_response.dart';
import '../widgets/deriv_dropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  final HomeStore _homeStore = locator.get<HomeStore>();

  @override
  void initState() {
    super.initState();
    _homeStore.getActiveSymbols();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.yellow,
        elevation: 5,
        centerTitle: true,
        title: const Text('Price Tracker'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Observer(builder: (BuildContext context) {
              switch (_homeStore.state) {
                case StoreState.loading:
                  return const Text('fetching data');
                case StoreState.loaded:
                  if (_homeStore.activeSymbolResponse != null &&
                      _homeStore.activeSymbolResponse!.activeSymbols != null) {
                    return DerivDropDown(
                      placeholder: 'Select a market',
                      onChanged: onMarketChanged,
                      dropdownValue: _homeStore.selectedMarket,
                      buildList: buildMarketList,
                    );
                  } else {
                    return Column(
                      children: const [
                        LottieWidget(lottieType: 'loading'),
                      ],
                    );
                  }
              }
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Observer(builder: (BuildContext context) {
              if (_homeStore.selectedMarket != null) {
                return DerivDropDown(
                  placeholder: 'Select a symbol',
                  onChanged: onSymbolChanged,
                  dropdownValue: _homeStore.selectedSymbol,
                  buildList: buildSymbolList,
                );
              } else {
                return const SizedBox();
              }
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Observer(builder: (BuildContext context) {
              if (_homeStore.selectedMarket != null &&
                  _homeStore.selectedSymbol != null &&
                  _homeStore.ticks != null) {
                final ticks = _homeStore.ticks;
                final prevTick = _homeStore.prevTicks;
                return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,

                    child: Center(
                        child: (ticks!.tick == null)
                            ? Column(
                                children: const [
                                  LottieWidget(
                                    lottieType: 'sad',
                                  ),
                                  Text(
                                    'Market Closed',
                                    style:
                                        TextStyle(color: Colors.yellowAccent),
                                  )
                                ],
                              )
                            : (prevTick != null &&
                                    prevTick.tick != null &&
                                    (ticks.tick!.quote!
                                            .compareTo(prevTick.tick!.quote!) >
                                        0))
                                ? DerivMarketText(
                                    text: ticks.tick!.quote.toString(),
                                    textColor: Colors.green,
                                    textIcon: Icons.arrow_circle_up,
                                  )
                                : DerivMarketText(
                                    text: ticks.tick!.quote.toString(),
                                    textColor: Colors.red,
                                    textIcon: Icons.arrow_circle_down,
                                  )));
              } else if (_homeStore.selectedSymbol != null &&
                  _homeStore.selectedMarket != null &&
                  _homeStore.ticks == null) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                      child: Column(
                    children: const [
                      LottieWidget(
                        lottieType: 'loading',
                      )
                    ],
                  )),
                );
              } else {
                return const Spacer();
              }
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  onMarketChanged(ActiveSymbol? value) {
    _homeStore.closeTicks();
    _homeStore.ticks = null;
    _homeStore.selectedSymbol = null;
    _homeStore.selectedMarket = null;
    if (value != null) {
      _homeStore.selectedMarket = value;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please try again')));
    }
  }

  onSymbolChanged(String? value) {
    _homeStore.closeTicks();
    _homeStore.ticks = null;
    _homeStore.selectedSymbol = null;
    if (value != null) {
      _homeStore.selectedSymbol = value;
      _homeStore.getTicks();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please try again')));
    }
  }

  List<DropdownMenuItem> buildSymbolList() {
    return [
      DropdownMenuItem<String>(
        value: _homeStore.selectedMarket!.symbol.toString(),
        child: Text(_homeStore.selectedMarket!.symbol.toString()),
      )
    ];
  }

  List<DropdownMenuItem<ActiveSymbol>> buildMarketList() {
    return _homeStore.activeSymbolResponse!.activeSymbols!
        .map((ActiveSymbol item) {
      return DropdownMenuItem<ActiveSymbol>(
        value: item,
        child: Text(item.displayName!),
      );
    }).toList();
  }
}
