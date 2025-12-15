import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Danh sách các bài tập (exercises) với thông tin chi tiết
  final List<Map<String, dynamic>> _exercises = const [
    {
      'title': '01. My Place',
      'route': '/myplace',
      'icon': Icons.location_on,
      'imagePath': 'assets/B1.png',
    },
    {
      'title': '02. My Widget',
      'route': '/mywidget',
      'icon': Icons.widgets,
      'imagePath': 'assets/B2.png',
    },
    {
      'title': '03. Guide Page',
      'route': '/guide',
      'icon': Icons.book,
      'imagePath': 'assets/B3.png',
    },
    {
      'title': '04. Counter App',
      'route': '/counter',
      'icon': Icons.add_circle,
      'imagePath': 'assets/B4.png',
    },
    {
      'title': '05. Change Color App',
      'route': '/changecolor',
      'icon': Icons.color_lens,
      'imagePath': 'assets/B5.png',
    },
    {
      'title': '06. Login Form',
      'route': '/loginform',
      'icon': Icons.login,
      'imagePath': 'assets/B6.png',
    },
    {
      'title': '07. Đăng Ký Screen',
      'route': '/dangky',
      'icon': Icons.app_registration,
      'imagePath': 'assets/B7.png',
    },
    {
      'title': '08. Form Phản Hồi',
      'route': '/phanhoi',
      'icon': Icons.feedback,
      'imagePath': 'assets/B8.png',
    },
    {
      'title': '09. Tính BMI',
      'route': '/bmi',
      'icon': Icons.monitor_weight,
      'imagePath': 'assets/B9.png',
    },
    {
      'title': '10. My Product',
      'route': '/myproduct',
      'icon': Icons.shopping_bag,
      'imagePath': 'assets/B10.png',
    },
    {
      'title': '11. News API',
      'route': '/Newsapi',
      'icon': Icons.public,
      'imagePath': 'assets/B11.png',
    },
    {
      'title': '12. Login/Logout',
      'route': '/loginpage',
      'icon': Icons.security,
      'imagePath': 'assets/B12.png',
    },
  ];

  // Hàm xây dựng các mục menu trong Drawer
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String routeName,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        // Đóng Drawer trước khi chuyển hướng
        Navigator.pop(context);
        Navigator.pushNamed(context, routeName);
      },
    );
  }

  // Hàm xây dựng Card cho GridView trong Body (có ảnh nền)
  Widget _buildExerciseCard(BuildContext context, Map<String, dynamic> item) {
    final String imagePath = item['imagePath'] as String;

    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAlias, // Cắt ảnh nền theo bo tròn của Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, item['route']),
        child: Container(
          decoration: BoxDecoration(
            // **Thiết lập hình ảnh nền**
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              // Thêm lớp mờ để Icon và Text nổi bật
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.45),
                BlendMode.darken,
              ),
            ),
          ),

          // **Nội dung đặt trên ảnh nền**
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    item['icon'] as IconData,
                    size: 40,
                    color: Colors.white, // Icon màu trắng
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white, // Text màu trắng
                      shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.black,
                        ), // Thêm shadow cho dễ đọc
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách Bài tập Flutter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),

      // --- Thiết kế Drawer (Menu bên) ---
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            // DrawerHeader hiện đại với Gradient
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.dashboard, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Kho Bài Tập Thực Hành',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Chọn một bài tập để bắt đầu.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Danh sách các mục menu cuộn được
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // Các mục bài tập
                  ..._exercises.map(
                    (item) => _buildDrawerItem(
                      context,
                      icon: item['icon'] as IconData,
                      title: item['title'] as String,
                      routeName: item['route'] as String,
                    ),
                  ),

                  const Divider(),

                  // Mục Home
                  _buildDrawerItem(
                    context,
                    icon: Icons.home,
                    title: 'Menu Chính (Home)',
                    routeName: '/',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // --- Thiết kế Body với GridView và Card có ảnh nền ---
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Danh Sách Bài Tập Thực Hành',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cột
                  childAspectRatio: 1.0, // Tỷ lệ 1:1 cho mỗi Card
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: _exercises.length,
                itemBuilder: (context, index) {
                  return _buildExerciseCard(context, _exercises[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
