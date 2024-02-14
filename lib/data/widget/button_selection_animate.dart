import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ButtonSelectionAnimation extends StatelessWidget {
  const ButtonSelectionAnimation({
    super.key,
    required this.onTap,
    required this.isButtonPressed,
    required this.nameButton,
  });

  final Function() onTap;
  final bool isButtonPressed;
  final String nameButton;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
        tween: Tween<double>(
          begin: isButtonPressed ? 1.0 : 0.95,
          end: isButtonPressed ? 0.95 : 1.0,
        ),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              // width: 120,
              height: height * 0.0437,
              decoration: BoxDecoration(
                border: isButtonPressed
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: brownBorderButton, width: 2),
                borderRadius: BorderRadius.circular(20),
                color: isButtonPressed
                    ? backgroundActiveButton
                    : backGroundButton,
                boxShadow: isButtonPressed
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(3, 3),
                          blurRadius: 5,
                          // spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: backGroundApplication,
                          offset: Offset(-3, -3),
                          blurRadius: 5,
                          // spreadRadius: 1,
                        )
                      ],
              ),
              child: Center(
                child: Text(
                  nameButton,
                  style: kfontH2InterBlackColor(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
