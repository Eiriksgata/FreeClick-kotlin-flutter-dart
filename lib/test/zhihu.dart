import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DraggableFloatingActionButtonDemo(),
    );
  }
}

class DraggableFloatingActionButtonDemo extends StatelessWidget {
  final GlobalKey _parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter Draggable Floating Action Button'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Container(
            width: 300,
            height: 300,
            child: Stack(
              key: _parentKey,
              children: [
                Container(color: Colors.cyan),
                const Center(
                  child: Text(
                    "FlutterDev's.com",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                DraggableFloatingActionButton(
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.transparent,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.withOpacity(0.4)),
                        child: const Text(
                          "+",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  initialOffset: const Offset(120, 70),
                  parentKey: _parentKey,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;

  DraggableFloatingActionButton({
    required this.child,
    required this.initialOffset,
    required this.onPressed,
    required GlobalKey<State<StatefulWidget>> parentKey,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  bool _isDragging = false;
  late Offset _offset;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);

          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          print('onPointerUp');

          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: widget.child,
      ),
    );
  }
}
