import 'package:flutter/material.dart';
import 'package:technical_test_consware/frames/login.dart';

class AnimatedSwitch extends StatefulWidget {
  const AnimatedSwitch({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  late bool remember;

  @override
  void initState() {
    super.initState();
    remember=false;
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 27,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: remember ? Colors.green:Colors.grey.withOpacity(0.5)
      ),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            top: 1.7,
            left: remember?15:0,
            right: remember?0:15,
            child: InkWell(
              onTap: () {
                setState(() {
                  rememberPassword=!remember;
                  remember=!remember;
                });
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(turns: animation, child: child);
                },
                child: remember?Icon(Icons.check_circle, key: UniqueKey(),):Icon(Icons.remove_circle_outline, key: UniqueKey(),)
              ),
            ),
          )
        ],
      ),
    );
  }
}