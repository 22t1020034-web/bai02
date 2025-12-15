import 'dart:convert';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// 1. DỮ LIỆU JSON ĐƯỢC YÊU CẦU
// ---------------------------------------------------------------------------
const String mockJsonData = '''
{
  "id": 1, 
  "firstName": "Emily", 
  "lastName": "Johnson", 
  "maidenName": "Smith", 
  "age": 29, 
  "gender": "female", 
  "email": "emily.johnson@x.dummyjson.com", 
  "phone": "+81 965-431-3024", 
  "username": "emilys", 
  "password": "emilyspass", 
  "birthDate": "1996-5-30", 
  "image": "https://dummyjson.com/icon/emilys/128", 
  "bloodGroup": "O-", 
  "height": 193.24, 
  "weight": 63.16, 
  "eyeColor": "Green", 
  "hair": { "color": "Brown", "type": "Curly" }, 
  "ip": "42.48.100.32", 
  "address": { 
    "address": "626 Main Street", "city": "Phoenix", "state": "Mississippi", 
    "stateCode": "MS", "postalCode": "29112", 
    "coordinates": { "lat": -77.16213, "lng": -92.084824 }, 
    "country": "United States" 
  }, 
  "macAddress": "47:fa:41:18:ec:eb", 
  "university": "University of Wisconsin--Madison", 
  "bank": { 
    "cardExpire": "05/28", "cardNumber": "3693233511855044", 
    "cardType": "Diners Club International", "currency": "GBP", 
    "iban": "GB74MH2UZLR9TRPHYNU8F8" 
  }, 
  "company": { 
    "department": "Engineering", "name": "Dooley, Kozey and Cronin", 
    "title": "Sales Manager", 
    "address": { 
      "address": "263 Tenth Street", "city": "San Francisco", "state": "Wisconsin", 
      "stateCode": "WI", "postalCode": "37657", 
      "coordinates": { "lat": 71.814525, "lng": -161.150263 }, 
      "country": "United States" 
    } 
  }, 
  "ein": "977-175", 
  "ssn": "900-590-289", 
  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36", 
  "crypto": { 
    "coin": "Bitcoin", "wallet": "0xb9fc2fe63b2a6c003f1c324c3bfa53259162181a", 
    "network": "Ethereum (ERC20)" 
  }, 
  "role": "admin" 
}
''';

// ---------------------------------------------------------------------------
// 2. MÀN HÌNH ĐĂNG NHẬP (LOGIN)
// ---------------------------------------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true; // Ẩn/hiện mật khẩu
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Hàm xử lý đăng nhập
  void _handleLogin() {
    // Parse dữ liệu từ chuỗi JSON
    final Map<String, dynamic> userData = jsonDecode(mockJsonData);

    // Lấy thông tin username/password từ JSON để so sánh
    final String validUser = userData['username'];
    final String validPass = userData['password'];

    // Kiểm tra input (Ở đây mình so sánh cứng với data JSON để demo)
    if (_userController.text == validUser &&
        _passController.text == validPass) {
      // YÊU CẦU: In ra 200 và accessToken
      print("Status Code: 200");
      // Giả lập accessToken vì JSON không có trường này, nhưng đề bài yêu cầu in ra
      print(
        "AccessToken: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMifQ",
      );

      // Chuyển sang màn hình Profile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(userData: userData),
        ),
      );
    } else {
      // Thông báo nếu sai (Gợi ý: username: emilys / pass: emilyspass)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sai tài khoản hoặc mật khẩu! (Thử: emilys / emilyspass)',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        156,
        65,
        187,
      ), // Màu nền tím nhạt giống ảnh
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa màn hình dọc
          children: [
            // Tiêu đề
            const Text(
              "Form Đăng nhập",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // Input Tên người dùng
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Colors.black54),
                hintText: "Tên người dùng",
                filled: true,
                fillColor: Colors.white, // Nền trắng cho input
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Mật khẩu
            TextField(
              controller: _passController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.black54),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                hintText: "Mật khẩu",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nút Đăng nhập
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                    255,
                    92,
                    103,
                    164,
                  ), // Màu tím rất nhạt cho nút
                  foregroundColor: const Color.fromARGB(
                    255,
                    35,
                    160,
                    72,
                  ), // Màu chữ
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bo tròn nhiều
                  ),
                  elevation: 0, // Bỏ bóng đổ để giống ảnh phẳng
                  side: const BorderSide(color: Colors.black12), // Viền mờ
                ),
                child: const Text(
                  "Đăng nhập",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. MÀN HÌNH PROFILE (SAU KHI ĐĂNG NHẬP)
// ---------------------------------------------------------------------------
class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepPurple.shade100,
        automaticallyImplyLeading: false, // Ẩn nút back mặc định
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Hiển thị ảnh đại diện từ JSON
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userData['image']),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 20),

            // Hiển thị thông tin
            Text(
              "${userData['firstName']} ${userData['lastName']}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Role: ${userData['role']}"),
            const Divider(height: 40),

            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(userData['email']),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Phone"),
              subtitle: Text(userData['phone']),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text("Company"),
              subtitle: Text(userData['company']['name']),
            ),

            const SizedBox(height: 40),

            // Nút Đăng xuất
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // YÊU CẦU: Quay lại màn hình đăng nhập
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                ),
                child: const Text("Đăng xuất"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
