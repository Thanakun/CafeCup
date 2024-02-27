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
  color: Colors.white60,
  borderRadius: BorderRadius.circular(15),
);
Decoration kdecorationForContainerBackButton = BoxDecoration(
    color: backGroundButton,
    border: Border.all(color: brownBorderButton),
    borderRadius: const BorderRadius.all(Radius.circular(20.0)));
Decoration kdecorationForContainerSelectSearchBox = const BoxDecoration(
    color: colorBackGroundSearchBox,
    border: Border(
        bottom: BorderSide(
      color: Colors.transparent,
    )),
    borderRadius: BorderRadius.all(Radius.circular(15.0)));
Decoration kdecorationForContainerSearchBar = BoxDecoration(
  color: backGroundApplication,
  borderRadius: BorderRadius.circular(15),
  border: const Border(
    bottom: BorderSide(color: Colors.black, width: 1.0),
  ),
);

Decoration kdecorationIconContainer = BoxDecoration(
  shape: BoxShape.circle,
  color: colorRedBackGroundIcon,
);

Decoration kdecorationButtonDisableContainer = BoxDecoration(
  color: Colors.white60,
  borderRadius: BorderRadius.circular(15),
  border: Border.all(
    color: brownBorderButton,
  )
);

Decoration kdecorationContainerBrownColor = BoxDecoration(
  color: colorBackGroundNavBar,
  borderRadius: BorderRadius.circular(100),
  border: Border.all(color: brownBorderButton, width: 2),
);

Decoration kdecorationForContainerbuttonSelectedSearchResultView =
    BoxDecoration(
  color: kYellowSelectedButtonSearchView,
  borderRadius: BorderRadius.circular(15),
  border: Border.all(color: brownBorderButton, width: 2),
);

Decoration kdecorationForContainerYellowProgressBar = BoxDecoration(
  color: kYellowSelectedButtonSearchView,
  borderRadius: BorderRadius.circular(100),
);

Decoration kdecorationButtonSelectedOrange = BoxDecoration(
  color: selectButtonColor,
  borderRadius: BorderRadius.circular(15),
);

Decoration kdecorationButtonUnSelectedOrange = BoxDecoration(
  color: backGroundButton.withOpacity(0.5),
  border: Border.all(color: brownBorderButton),
  borderRadius: BorderRadius.circular(15),
);
