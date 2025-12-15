import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  final List<Map<String, dynamic>> _itemConfigs = const [
    {'imagePath': 'assets/A1.png', 'color': Color.fromARGB(255, 33, 40, 52)},

    {'imagePath': 'assets/A2.png', 'color': Color.fromARGB(255, 207, 73, 50)},

    {
      'imagePath': 'assets/A3.png.jpg',
      'color': Color.fromARGB(255, 39, 90, 149),
    },

    {'imagePath': 'assets/A4.png', 'color': Color.fromARGB(255, 230, 126, 34)},

    {'imagePath': 'assets/A5.png', 'color': Color.fromARGB(255, 52, 73, 94)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: myBody()));
  }

  Widget myBody() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(_itemConfigs.length, (index) => item(index)),
    );
  }

  Widget item(int index) {
    final config = _itemConfigs[index];
    final String imagePath = config['imagePath'];
    final Color defaultColor = config['color'];

    DecorationImage? backgroundImage;

    if (imagePath.isNotEmpty) {
      backgroundImage = DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.darken,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      height: 120,

      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 190, 81, 81)),
        color: defaultColor,
        borderRadius: BorderRadius.circular(10),
        image: backgroundImage,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lập trình di động $index",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Nguyễn Dũng",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Text("30 Sinh viên", style: TextStyle(color: Colors.white54)),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                print("Hello");
              },
              icon: Icon(Icons.more_horiz, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
