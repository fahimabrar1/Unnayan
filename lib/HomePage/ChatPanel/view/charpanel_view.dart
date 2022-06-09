import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Duration duration = new Duration();
  Duration position = new Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text("User Name"),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BubbleNormal(
                  text: 'bubble normal with tail',
                  isSender: false,
                  color: Color(0xFF1B97F3),
                  tail: true,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                BubbleNormal(
                  text: 'bubble normal with tail',
                  isSender: true,
                  color: Color(0xFFE8E8EE),
                  tail: true,
                  sent: true,
                ),
                DateChip(
                  date: new DateTime(now.year, now.month, now.day - 2),
                ),
                BubbleNormal(
                  text: 'bubble normal without tail',
                  isSender: false,
                  color: Color(0xFF1B97F3),
                  tail: false,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                BubbleNormal(
                  text: 'bubble normal without tail',
                  color: Color(0xFFE8E8EE),
                  tail: false,
                  sent: true,
                  seen: true,
                  delivered: true,
                ),
                BubbleSpecialOne(
                  text: 'bubble special one with tail',
                  isSender: false,
                  color: Color(0xFF1B97F3),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                DateChip(
                  date: new DateTime(now.year, now.month, now.day - 1),
                ),
                BubbleSpecialOne(
                  text: 'bubble special one with tail',
                  color: Color(0xFFE8E8EE),
                  seen: true,
                ),
                BubbleSpecialOne(
                  text: 'bubble special one without tail',
                  isSender: false,
                  tail: false,
                  color: Color(0xFF1B97F3),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                BubbleSpecialOne(
                  text: 'bubble special one without tail',
                  tail: false,
                  color: Color(0xFFE8E8EE),
                  sent: true,
                ),
                BubbleSpecialTwo(
                  text: 'bubble special tow with tail',
                  isSender: false,
                  color: Color(0xFF1B97F3),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                DateChip(
                  date: now,
                ),
                BubbleSpecialTwo(
                  text: 'bubble special tow with tail',
                  isSender: true,
                  color: Color(0xFFE8E8EE),
                  sent: true,
                ),
                BubbleSpecialTwo(
                  text: 'bubble special tow without tail',
                  isSender: false,
                  tail: false,
                  color: Color(0xFF1B97F3),
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                BubbleSpecialTwo(
                  text: 'bubble special tow without tail',
                  tail: false,
                  color: Color(0xFFE8E8EE),
                  delivered: true,
                ),
                BubbleSpecialThree(
                  text: 'bubble special three without tail',
                  color: Color(0xFF1B97F3),
                  tail: false,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'bubble special three with tail',
                  color: Color(0xFF1B97F3),
                  tail: true,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: "bubble special three without tail",
                  color: Color(0xFFE8E8EE),
                  tail: false,
                  isSender: false,
                ),
                BubbleSpecialThree(
                  text: "bubble special three with tail",
                  color: Color(0xFFE8E8EE),
                  tail: true,
                  isSender: false,
                ),
              ],
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }
}

class ChatPanel extends StatefulWidget {
  const ChatPanel({Key? key}) : super(key: key);

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const FlutterLogo(),
              ),
              title: const Text('User Name'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const FlutterLogo(),
              ),
              title: const Text('User Name'),
              onTap: () {},
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const FlutterLogo(),
              ),
              title: const Text('User Name'),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
