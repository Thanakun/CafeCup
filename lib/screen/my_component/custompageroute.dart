import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/search_page.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({
    required this.child,
  }) : super(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, searchAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> searchAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
