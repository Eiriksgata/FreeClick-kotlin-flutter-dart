
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Application {
  ///应用全局 ke
  static GlobalKey<NavigatorState>?  globalKey;
  static OverlayEntry? overlayEntry;
}

void main() {
  GlobalKey<NavigatorState> globalKey = new  GlobalKey<NavigatorState>();
  Application.globalKey = globalKey;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///注意 一定要navigatorKey 才能在所有界面上显示
      navigatorKey: Application.globalKey,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ///WidgetsBinding.instance.addPostFrameCallback 这个作用是界面绘制完成的监听回调  必须在绘制完成后添加OverlayEntry
      ///MediaQuery.of(context).size.width  屏幕宽度
      ///MediaQuery.of(context).size.height 屏幕高度
      addOverlayEntry(
          MediaQuery.of(context).size.width - 80,
          MediaQuery.of(context).size.height - 80);
    });
  }

  Future addOverlayEntry(double left, double top) async {
    Application.overlayEntry?.remove();

    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top:  top,
          left: left,
          child: GestureDetector(
              onTap: () async{
                ///在这里实现拨打客服电话功能
                const url = 'tel:17601290637';

              },

              child: Draggable(
                  onDragEnd: (DraggableDetails details) {
                    ///拖动结束
                    addOverlayEntry(details.offset.dx, details.offset.dy);
                  },
                  ///feedback是拖动时跟随手指滑动的Widget。
                  feedback: Icon(Icons.add_call, color: Colors.red,),
                  ///child是静止时显示的Widget，
                  child: Icon(Icons.add_call, color: Colors.red,))
          ),
        )
    );
    /// 赋值  方便移除
    Application.overlayEntry = overlayEntry;
    Application.globalKey!.currentState!.overlay!.insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
