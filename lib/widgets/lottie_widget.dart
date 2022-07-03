import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget(
      {Key? key, this.lottieType, this.lottieWidth, this.lottieDuration})
      : super(key: key);

  @override
  LottieWidgetState createState() {
    return LottieWidgetState();
  }
  final String? lottieType;
  final double? lottieWidth;
  final int? lottieDuration;
}

class LottieWidgetState extends State<LottieWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (widget.lottieWidth != null)
          ? widget.lottieWidth
          : MediaQuery.of(context).size.width * 0.3,
      child: loadLottie(widget.lottieType, context),
    );
  }

  loadLottie(lottieType, context) {
    switch (lottieType) {
      case 'loading':
        return fetchLottie(context, 'asset/lottie/loading.json');
      case 'sad':
        return fetchLottie(context, 'asset/lottie/sad.json');
    }
  }

  LottieBuilder fetchLottie(context, path) {
    return Lottie.asset(
      path,
      key: UniqueKey(),
      frameBuilder: (context, child, composition) {
        return AnimatedOpacity(
          opacity: 1,
          duration: Duration(
              seconds: (widget.lottieDuration != null)
                  ? widget.lottieDuration!
                  : 120),
          child: child,
        );
      },
    );
  }
}
