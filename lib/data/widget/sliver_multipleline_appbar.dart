import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

class SliverMultilineAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;

  SliverMultilineAppBar(
      {required this.title, required this.leading, required this.actions});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    double availableWidth = mediaQuery.size.width - 160;
    availableWidth -= 32 * actions.length;
    availableWidth -= 32;

    return SliverAppBar(
      centerTitle: true,
      expandedHeight: 120.0,
      forceElevated: true,
      leading: leading,
      actions: actions,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: availableWidth,
          ),
          child: Text(
            title,
            style: kfontH2InterBlackColor(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
