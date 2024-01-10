import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

class ShopStatusBarRegister extends StatefulWidget {
  const ShopStatusBarRegister({
    super.key,
    required this.shopIndicatorRegistationState,
  });

  final int shopIndicatorRegistationState;

  @override
  State<ShopStatusBarRegister> createState() => _ShopStatusBarRegisterState();
}

class _ShopStatusBarRegisterState extends State<ShopStatusBarRegister> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            statusBar(0),
            statusBar(1),
            statusBar(2),
            statusBar(3),
          ],
        ),
      ),
    );
  }

  Widget statusBar(int index) {
    bool isActive = index < widget.shopIndicatorRegistationState;
    return Container(
      width: 60,
      height: 10,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isActive
                ? Colors.green.withOpacity(0.5)
                : Colors.brown.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: isActive ? sup3V4 : main1V4,
      ),
    );
  }
}
