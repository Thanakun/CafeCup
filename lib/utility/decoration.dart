import 'package:coffee_application/utility/my_constant.dart';
import 'package:flutter/material.dart';

Decoration kdecorationForContainerActiveItem = BoxDecoration(
    color: backgroundActiveButton, borderRadius: BorderRadius.circular(15));
Decoration kdecorationForContainerAcceptButton = BoxDecoration(
    color: kcolorAcceptButton, borderRadius: BorderRadius.circular(20));
Decoration kdecorationForContainerAcceptFloatingButton = BoxDecoration(
    color: kcolorAcceptButton, borderRadius: BorderRadius.circular(100));
Decoration kdecorationForContainerButton = BoxDecoration(
    color: backgroundActiveButton, borderRadius: BorderRadius.circular(100));

Decoration kdecorationForContainerActiveBeingSelected = BoxDecoration(
    color: brownBorderButton, borderRadius: BorderRadius.circular(15));
Decoration kdecorationForContainerApplication = BoxDecoration(
    color: backGroundApplication, borderRadius: BorderRadius.circular(15));
Decoration kdecorationForContainerDisabled = BoxDecoration(
    color: Colors.grey.shade400, borderRadius: BorderRadius.circular(15));
Decoration kdecorationForContainerBackButton = BoxDecoration(
    color: backGroundButton,
    border: Border.all(color: brownBorderButton),
    borderRadius: const BorderRadius.all(Radius.circular(20.0)));
