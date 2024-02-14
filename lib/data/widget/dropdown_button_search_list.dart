import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utility/my_constant.dart';

class DropDownSearchListWidget extends StatefulWidget {
  const DropDownSearchListWidget(
      {required this.width,
      required this.height,
      required this.header,
      required this.listOfItem,
      required this.selectedItem,
      required this.searchTextMenuList,
      required this.onSelectMenuItem,
      required this.isEnableSearch,
      super.key});

  final bool isEnableSearch;
  final Function onSelectMenuItem;
  final TextEditingController searchTextMenuList;
  final String? selectedItem;
  final double width;
  final double height;
  final String header;
  final List<DropdownMenuItem> listOfItem;
  
  @override
  State<DropDownSearchListWidget> createState() =>
      _DropDownSearchListWidgetState();
}

class _DropDownSearchListWidgetState extends State<DropDownSearchListWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: widget.listOfItem,
        value: widget.selectedItem,
        hint: Text(
          widget.header,
          style: kfontH2InterBlackColorHalfOpacity(),
        ),
        onChanged: (value) {
          widget.onSelectMenuItem(value);
        },
        style: kfontH2InterBlackColor(),
        buttonStyleData:
            buttonStyleDropDown(height: widget.height, width: widget.width),
        dropdownStyleData: dropdownStyleBox(
          height: widget.height,
        ),
        menuItemStyleData: menuItemStyleBox(
          height: widget.height,
        ),
        dropdownSearchData: widget.isEnableSearch ?
            dropdownSearchBox(height: widget.height, width: widget.width) : DropdownSearchData(),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.searchTextMenuList.clear();
          }
        },
      ),
    );
  }

  DropdownSearchData<Object?> dropdownSearchBox(
      {required height, required width}) {
    return DropdownSearchData(
      searchController: widget.searchTextMenuList,
      searchInnerWidgetHeight: height * 0.0546,
      searchInnerWidget: Container(
        height: height * 0.0546,
        padding: EdgeInsets.only(
          top: height * 0.008,
          bottom: height * 0.004,
          right: width * 0.0194,
          left: width * 0.0194,
        ),
        child: TextFormField(
          expands: true,
          maxLines: null,
          controller: widget.searchTextMenuList,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.024,
              vertical: height * 0.008,
            ),
            hintText: 'Search for an item...',
            hintStyle: kfontH4InterBlackColorHalfOpacity(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      searchMatchFn: (item, searchValue) {
        return item.value.toString().contains(searchValue);
      },
    );
  }

  MenuItemStyleData menuItemStyleBox({required height}) {
    return MenuItemStyleData(
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      height: height * 0.0437,
    );
  }

  DropdownStyleData dropdownStyleBox({required height}) {
    return DropdownStyleData(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      maxHeight: height * 0.2185,
    );
  }

  ButtonStyleData buttonStyleDropDown({required height, required width}) {
    return ButtonStyleData(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color.fromRGBO(226, 199, 153, 1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.symmetric(horizontal: width * 0.0388),
      height: height * 0.0437,
      width: double.infinity,
    );
  }
}
