import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công!'),

          backgroundColor: Colors.green,

          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' Login')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              // --- Trường Tên người dùng ---
              TextFormField(
                controller: _usernameController,

                decoration: const InputDecoration(
                  labelText: 'Tên người dùng',

                  hintText: 'Nhập tên người dùng',

                  border: OutlineInputBorder(),

                  prefixIcon: Icon(Icons.person),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tên người dùng không được để trống';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // --- Trường Mật khẩu (với biểu tượng con mắt) ---
              TextFormField(
                controller: _passwordController,

                obscureText:
                    !_isPasswordVisible, // Sử dụng biến trạng thái ở đây

                decoration: InputDecoration(
                  labelText: 'Mật khẩu',

                  hintText: 'Nhập mật khẩu (>= 6 ký tự)',

                  border: const OutlineInputBorder(),

                  prefixIcon: const Icon(Icons.lock),

                  // Thêm suffixIcon để hiển thị biểu tượng con mắt
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Thay đổi icon tùy thuộc vào trạng thái _isPasswordVisible
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      // Cập nhật trạng thái khi icon được nhấn

                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mật khẩu không được để trống';
                  }

                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _login,

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),

                child: const Text('Đăng nhập', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
