import 'package:flutter/material.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/my_color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "subtitle": "This is my subtitle"},
    {"id": 2, "name": "Aragon", "subtitle": "This is my subtitle"},
    {"id": 3, "name": "Bob", "subtitle": "This is my subtitle"},
    {"id": 4, "name": "Barbara", "subtitle": "This is my subtitle"},
    {"id": 5, "name": "Candy", "subtitle": "This is my subtitle"},
    {"id": 6, "name": "Colin", "subtitle": "This is my subtitle"},
    {"id": 7, "name": "Audra", "subtitle": "This is my subtitle"},
    {"id": 8, "name": "Banana", "subtitle": "This is my subtitle"},
    {"id": 9, "name": "Caversky", "subtitle": "This is my subtitle"},
    {"id": 10, "name": "Becky", "subtitle": "This is my subtitle"},
  ];
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  void initState() {
    _foundUsers = _allUsers;

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.darkBackground,
      child: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Heading',
                style: CustomTextStyle.textStyle(MyColor.white, 18),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => _runFilter(val),
              decoration: const InputDecoration(
                filled: true,
                fillColor: MyColor.whiteLowOpacity,
                labelText: "Search",
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColor.blackFont),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return NotificationTile(index, _foundUsers);
            },
            childCount: _foundUsers.length,
          ),
        ),
      ]
          // Column(
          //   children: [

          //     Expanded(
          //       child: ListView.builder(
          //         itemBuilder: ((context, index) {
          //           return NotificationTile(index, _foundUsers);
          //         }),
          //         itemCount: _foundUsers.length,
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}

class NotificationTile extends StatefulWidget {
  final int index;
  List<Map<String, dynamic>> foundUsers;
  NotificationTile(this.index, this.foundUsers, {Key? key}) : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Card(
                color: MyColor.whiteLowOpacity,
                child: ListTile(
                  leading: const FlutterLogo(
                    size: 30,
                  ),
                  title: Text(widget.foundUsers[widget.index]["name"]),
                  subtitle: Text(widget.foundUsers[widget.index]["subtitle"]),
                  onTap: () {},
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          color: MyColor.blackFont,
        ),
      ],
    );
  }
}
