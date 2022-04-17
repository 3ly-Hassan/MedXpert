import 'package:final_pro/constants.dart';
import 'package:final_pro/size_config.dart';
import 'package:flutter/material.dart';

class NoFollowersWidget extends StatefulWidget {
  final String msg;
  const NoFollowersWidget({Key? key, required this.msg}) : super(key: key);

  @override
  State<NoFollowersWidget> createState() => _NoFollowersWidgetState();
}

class _NoFollowersWidgetState extends State<NoFollowersWidget>
    with TickerProviderStateMixin {
  //
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: kNoFollowersAnimationDuration),
  );
  //
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.reset();
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      //ToDo: note :All this complex logic is just for centering the widgets in list view!
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/relax.png',
                  ),
                  SizedBox(
                    height:
                        SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                            0.011,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.msg,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline6!.fontSize,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
