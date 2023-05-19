import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/viewmodel/search_view_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  SearchViewModel _searchViewModel = SearchViewModel();

  @override
  void initState() {
    _searchViewModel.fetchAllShopItem();
    print(_searchViewModel.listAllShopFuture);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 345,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                _searchViewModel.onUserSearchItemFilter(value);
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              suffixIcon: IconButton(
                padding: EdgeInsets.all(2),
                key: Key("microphone"),
                onPressed: () {
                  // print("Clicking mic icon");
                },
                icon: Icon(Icons.mic),
              ),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Search for...',
              hintStyle: TextStyle(color: Colors.grey.shade400),
            ),
          ),
        ),
        actions: [
          ZoomTapAnimation(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _searchViewModel.listFilterShopFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final searchResult = snapshot.data;
            print(snapshot.data.length);
            print(_searchViewModel.listAllShopFuture);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data[index].shopName.toString());
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final searchResult = snapshot.data;
          } else {
            return Center(
              child: Text("No data avaliable"),
            );
          }

          return Center(
            child: Text("No data avaliable"),
          );
        },
      ),
    );
  }
}

// ListView.builder(
//           itemCount: _searchViewModel.listFilterShopFuture?.length,
//           itemBuilder: (context, index) {
//             return Text(_searchViewModel.listFilterShopFuture.toString());
//           },
//         ),
