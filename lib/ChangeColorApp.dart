import 'package:flutter/material.dart';
import 'dart:math';

class ChangeColorApp extends StatefulWidget {
  const ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorApp();
}

class _ChangeColorApp extends State<ChangeColorApp> {
  late Color currentColor = Colors.purple;
  List<Color> colors = [
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    currentColor = Colors.purple;
  }

  void changeColor() {
    var random = Random();
    setState(() {
      currentColor = colors[random.nextInt(colors.length)];
    });
  }

  void resetColor() {
    setState(() {
      currentColor = Colors.purple;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: myAppBar(), body: myBody());
  }

  myBody() {
    return Container(
      decoration: BoxDecoration(color: currentColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Màu sắc hiện tại"),
          Text(
            getColorName(currentColor),
            style: TextStyle(
              color: currentColor == Colors.purple ? Colors.purple : Colors.red,
              fontSize: 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: changeColor,
                label: Text("Đổi màu"),
                icon: Icon(Icons.color_lens),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: resetColor,
                label: Text("Đặt lại"),
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getColorName(Color color) {
    if (color == Colors.purple) return "Tím";
    if (color == Colors.orange) return "Cam";
    if (color == Colors.green) return "Xanh lá";
    if (color == Colors.blue) return "Xanh dương";
    return "Không xác định";
  }

  myAppBar() {
    return AppBar(
      title: Text("Ứng dụng đổi màu"),
      backgroundColor: const Color.fromARGB(255, 183, 17, 131),
      foregroundColor: Colors.white,
      centerTitle: true,
    );
  }
}
