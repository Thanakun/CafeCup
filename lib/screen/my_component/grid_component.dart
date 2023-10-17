import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_constant.dart';

class BuildGridView extends StatefulWidget {
  const BuildGridView(
      {Key? key, required this.selectedList, required this.sectionHeightList})
      : super(key: key);
  final List selectedList;
  final double sectionHeightList;

  @override
  State<BuildGridView> createState() => _BuildGridViewState();
}

class _BuildGridViewState extends State<BuildGridView> {
  String name = "Ford";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.sectionHeightList,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21, vertical: 13),
        child: widget.selectedList.isEmpty
            ? Container() // Return an empty container when the list is empty
            : GridView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2.5 / 2.4,
                  crossAxisSpacing: 21,
                  mainAxisSpacing: 13,
                ),
                itemCount: widget.selectedList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        print(name);
                        name = 'Thoop';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              widget.selectedList[index]["name"],
                              style: kfontH2InterWhiteColor(),
                            ),
                          ),
                          Text(
                            widget.selectedList[index]["shoptype"],
                            style: kfontH3InterBlackColor(),
                          ),
                          Text(
                            name,
                            style: kfontH3InterBlackColor(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
// Widget buildGridView(List selectedList,VoidCallback setName) {
//   String name = "";

//   return 
// }
