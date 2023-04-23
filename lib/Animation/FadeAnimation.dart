// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;

//   FadeAnimation(this.delay, this.child);

//   @override
//    Widget build(BuildContext context) {
//     // Specify your tween
//     final tween = MovieTween()
//           .tween('y', Tween(begin: -100.0, end: 100.0),
//               duration: const Duration(seconds: 1));

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//           offset: Offset(0, animation["translateY"]), 
//           child: child
//         ),
//       ),
//     );
//   }
// }