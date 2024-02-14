import 'package:coffee_application/data/widget/dropdown_button_search_list.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/customer_register_second_view.dart';
import 'package:coffee_application/screen/shop_text_field_form.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late RegisterVM registerVM;
  final formKey = GlobalKey<FormState>();

  final TextEditingController searchTextMenuGenders = TextEditingController();
  final TextEditingController searchTextMenuAges = TextEditingController();
  final TextEditingController searchTextMenuJobs = TextEditingController();
  final TextEditingController searchTextMenuFavorites = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  String? selectedGender;
  String? selectedAges;
  String? selectedJobs;

  List<String> genders = ["MALE", "FEMALE"];
  List<String> ages = ['UNDER_22', '23_TO_40', '41_TO_60', 'AFTER_61'];
  List<String> jobs = [
    "Employee (Staff) in a company",
    "Engineer",
    "Doctor",
    "Artist",
    "IT Programmer",
    "Book Writer",
    "Student",
    "Officer",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerVM = RegisterVM(
        customerProvider: context.read<CustomerProvider>(),
        shopProvider: context.read<ShopProvider>());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(255, 245, 233, 1),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Form(
                  key: formKey,
                  child: Container(
                      width: width,
                      height: height,
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.07281,
                          vertical: height * 0.0163),
                      child: Column(
                        children: [
                          headerContainer(
                            header: "CUSTOMER_REGISTER.HEADER_INFORMATION".tr(),
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: headingContainer(
                                header: "CUSTOMER_REGISTER.NAME".tr()),
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          TextFieldContainer(
                              hightContainer: 50,
                              controller: usernameController,
                              hintText:
                                  "CUSTOMER_REGISTER.HINT_TEXT.NAME".tr()),
                          sectionBufferHeight(bufferSection: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: headingContainer(
                                header: "CUSTOMER_REGISTER.GENDER".tr()),
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          DropDownSearchListWidget(
                            isEnableSearch: true,
                            width: width,
                            height: height,
                            header: "CUSTOMER_REGISTER.HINT_TEXT.GENDER".tr(),
                            listOfItem: Helper.listToDropDownMenuItem(genders),
                            selectedItem: selectedGender,
                            searchTextMenuList: searchTextMenuGenders,
                            onSelectMenuItem: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: headingContainer(
                                header: "CUSTOMER_REGISTER.AGE".tr()),
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          DropDownSearchListWidget(
                            isEnableSearch: true,
                            width: width,
                            height: height,
                            header: "CUSTOMER_REGISTER.HINT_TEXT.AGE".tr(),
                            listOfItem: Helper.listToDropDownMenuItem(ages),
                            selectedItem: selectedAges,
                            searchTextMenuList: searchTextMenuAges,
                            onSelectMenuItem: (value) {
                              setState(() {
                                selectedAges = value;
                              });
                            },
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: headingContainer(
                                header: "CUSTOMER_REGISTER.OCCUPATION".tr()),
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          DropDownSearchListWidget(
                            isEnableSearch: true,
                            width: width,
                            height: height,
                            header:
                                "CUSTOMER_REGISTER.HINT_TEXT.OCCUPATION".tr(),
                            listOfItem: Helper.listToDropDownMenuItem(jobs),
                            selectedItem: selectedJobs,
                            searchTextMenuList: searchTextMenuJobs,
                            onSelectMenuItem: (value) {
                              setState(() {
                                selectedJobs = value;
                              });
                            },
                          ),
                          sectionBufferHeight(bufferSection: 16),
                          const Spacer(),
                          InkWell(
                            splashColor: Colors.greenAccent,
                            onTap: () {
                              //TODO Shop First
                              if (usernameController.text.isEmpty ||
                                  selectedGender == null ||
                                  selectedAges == null ||
                                  selectedJobs == null) {
                                // Display an error message or perform some action for invalid input
                                Utility.flushBarErrorMessage(
                                    message: "Please insert data information",
                                    context: context);
                                return;
                              }

                              setState(() {
                                registerVM.signUpSecondPage(
                                    name: usernameController.text,
                                    age: selectedAges,
                                    gender: selectedGender,
                                    occupation: selectedJobs);

                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerRegisterSecond(),
                                    ));
                                // Add more logic as needed
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              width: double.infinity,
                              height: constraints.maxHeight * 0.07,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Center(
                                child: Text(
                                  "BUTTON.NEXT_PAGE".tr(),
                                  style: kfontH1InterBoldBlackColor(),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
