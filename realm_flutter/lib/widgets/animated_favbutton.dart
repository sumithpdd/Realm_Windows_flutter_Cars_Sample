import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realm_flutter/models/model.dart';

import '../constants.dart';
import '../services/dbservice.dart';

class AnimatedFavourite extends StatefulWidget {
  final bool isFavorite;
  final Car car;

  const AnimatedFavourite(
      {Key? key, required this.isFavorite, required this.car})
      : super(key: key);

  @override
  _AnimatedFavouriteState createState() =>
      _AnimatedFavouriteState(isFavorite, car);
}

enum ScoreWidgetStatus { hidden, becomingVisible, visible, becomingInVisible }

class _AnimatedFavouriteState extends State<AnimatedFavourite>
    with TickerProviderStateMixin {
  bool isFavorite;
  final Car car;

  _AnimatedFavouriteState(this.isFavorite, this.car);

  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.hidden;
  final duration = const Duration(milliseconds: 100);
  final oneSecond = const Duration(milliseconds: 250);
  Timer? scoreOutETA;
  late AnimationController scoreInAnimationController,
      scoreOutAnimationController,
      scoreSizeAnimationController;
  late Animation scoreOutPositionAnimation;

  @override
  initState() {
    super.initState();
    scoreInAnimationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    scoreInAnimationController.addListener(() {
      setState(() {}); // Calls render function
    });

    scoreOutAnimationController =
        AnimationController(duration: duration, vsync: this);
    scoreOutPositionAnimation = Tween(begin: 100.0, end: 200.0).animate(
        CurvedAnimation(
            parent: scoreOutAnimationController, curve: Curves.easeOut));
    scoreOutPositionAnimation.addListener(() {
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.hidden;
      }
    });

    scoreSizeAnimationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    scoreSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
  }

  void increment(Timer? t) {
    scoreSizeAnimationController.forward(from: 0.0);
    _onPressed();
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    if (scoreOutETA != null) {
      scoreOutETA!.cancel(); // We do not want the score to vanish!
    }
    if (_scoreWidgetStatus == ScoreWidgetStatus.becomingInVisible) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.visible;
    } else if (_scoreWidgetStatus == ScoreWidgetStatus.hidden) {
      _scoreWidgetStatus = ScoreWidgetStatus.becomingVisible;
      scoreInAnimationController.forward(from: 0.0);
    }
    increment(null); // Take care of tap
    // holdTimer = new Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    // User removed his finger from button.
    scoreOutETA = Timer(oneSecond, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.becomingInVisible;
    });
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.hidden:
        break;
      case ScoreWidgetStatus.becomingVisible:
      case ScoreWidgetStatus.visible:
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 10;
        break;
      case ScoreWidgetStatus.becomingInVisible:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }
    return Positioned(
        child: Opacity(
            opacity: scoreOpacity,
            child: SizedBox(
                height: 25.0 + extraSize,
                width: 25.0 + extraSize,
                child: Center(
                    child: !isFavorite
                        ? const Icon(Icons.sentiment_dissatisfied,
                            color: kSecondaryLabelColor, size: 15.0)
                        : const Icon(Icons.favorite_border,
                            color: kSecondaryLabelColor, size: 15.0)))),
        bottom: scorePosition);
  }

  Widget getFavouriteButton() {
    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.visible ||
        _scoreWidgetStatus == ScoreWidgetStatus.becomingVisible) {
      extraSize = scoreSizeAnimationController.value * 10;
    }
    return GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: Container(
          height: 25.0 + extraSize,
          width: 25.0 + extraSize,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.redAccent, blurRadius: 2.0)
              ]),
          child: isFavorite
              ? const Icon(Icons.favorite,
                  color: kCourseElementIconColor, size: 15.0)
              : const Icon(Icons.favorite_border,
                  color: kSecondaryLabelColor, size: 15.0),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            getScoreButton(),
            getFavouriteButton(),
          ],
        ));
  }

  void _onPressed() {
    DatabaseService _databaseService = DatabaseService();

    if (isFavorite) {
      DatabaseService _databaseService = DatabaseService();
      _databaseService.addCarToMe(car);
    } else {
      _databaseService.removeCarFromMe(car);
    }
  }
}
