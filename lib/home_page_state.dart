import 'dart:ui';
import 'package:flutter/material.dart';

import 'float_button_container.dart';
import 'home_page.dart';
import 'main.dart';

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool draggable = false;

  //静止状态下的offset
  Offset idleOffset = const Offset(0, 0);

  //本次移动的offset
  Offset moveOffset = const Offset(0, 0);

  //最后一次down事件的offset
  Offset lastStartOffset = const Offset(0, 0);
  int count = 0;

  var temp;

  final List<String> testWidgetList = [
    '测试1',
    '测试2',
  ];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      moveOffset = moveOffset + const Offset(11, 11);
    });
  }

  void _insertOverlay() {
    Application.globalKey!.currentState!.overlay!
        .insert(OverlayEntry(builder: (context) {
      return Positioned(
        top: moveOffset.dy,
        left: moveOffset.dx,
        child: GestureDetector(
          // 移动中
          onPanUpdate: (DragUpdateDetails details) {
            moveOffset = details.globalPosition - const Offset(11, 11);
            print("$moveOffset");
          },
          child: const TestContainer(),
        ),
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _insertOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // WidgetsBinding.instance!
    //     .addPostFrameCallback((_) => _insertOverlay(context));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => {},
              child: Text('Increment'),
            ),
            const IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
            ),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
