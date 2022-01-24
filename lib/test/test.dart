import 'package:flutter/material.dart';

import '../drag.dart';
import '../home_page.dart';

void main() {
  runApp(const FloatButton());
}

class FloatButton extends StatelessWidget {
  const FloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'FloatButton',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    WidgetsBinding.instance!.addPersistentFrameCallback((timeStamp) {


    });

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body:
            Center() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class SuspensionAssembly extends StatefulWidget {
  SuspensionAssembly({Key? key}) : super(key: key);

  @override
  State<SuspensionAssembly> createState() => SuspensionAssemblyState();
}

class SuspensionAssemblyState extends State<SuspensionAssembly> {
  //本次移动的offset
  Offset moveOffset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // TODO: implement build
    return Positioned(
        top: moveOffset.dy,
        left: moveOffset.dx,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              moveOffset = details.globalPosition - const Offset(11, 11);
            });
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green.withOpacity(0.4)),
              child: const Text(
                "+",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
