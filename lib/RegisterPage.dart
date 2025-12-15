import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // GlobalKey để xác định và validate Form
  final _formKey = GlobalKey<FormState>();

  // Controllers để lấy dữ liệu
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Biến trạng thái để kiểm soát việc ẩn/hiện mật khẩu
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi nút Đăng ký được nhấn
  void _register() {
    // Kiểm tra xem Form hiện tại có hợp lệ không
    if (_formKey.currentState!.validate()) {
      // Nếu hợp lệ, hiển thị SnackBar thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thành công!'),
          backgroundColor: Color.fromARGB(255, 183, 58, 133),
          duration: Duration(seconds: 2),
        ),
      );
      // Thêm logic xử lý đăng ký thực tế ở đây
    }
  }

  // Widget chung cho các trường nhập liệu
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool isPassword = false,
    bool isEmail = false,
    String? Function(String?)? validator,
    required bool isObscure,
    required Function(bool) onVisibilityToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText:
          isObscure && isPassword, // Chỉ ẩn khi là mật khẩu và trạng thái là ẩn
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => onVisibilityToggle(!isObscure),
              )
            : null,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Đăng ký Tài khoản',
          style: TextStyle(color: Color.fromARGB(255, 19, 23, 253)),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, // Gán GlobalKey cho Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 1. Họ Tên ---
              _buildTextFormField(
                controller: _fullNameController,
                labelText: 'Họ Tên',
                prefixIcon: Icons.person,
                isObscure: false,
                onVisibilityToggle: (_) {}, // Không dùng cho trường này
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Họ tên không được để trống';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- 2. Email ---
              _buildTextFormField(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: Icons.email,
                isEmail: true,
                isObscure: false,
                onVisibilityToggle: (_) {}, // Không dùng cho trường này
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email không được để trống';
                  }
                  // Regex kiểm tra định dạng email cơ bản
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- 3. Mật khẩu ---
              _buildTextFormField(
                controller: _passwordController,
                labelText: 'Mật khẩu',
                prefixIcon: Icons.lock,
                isPassword: true,
                isObscure: !_isPasswordVisible,
                onVisibilityToggle: (isVisible) {
                  setState(() {
                    _isPasswordVisible = isVisible;
                  });
                },
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
              const SizedBox(height: 16),

              // --- 4. Xác nhận mật khẩu ---
              _buildTextFormField(
                controller: _confirmPasswordController,
                labelText: 'Xác nhận mật khẩu',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                isObscure: !_isConfirmPasswordVisible,
                onVisibilityToggle: (isVisible) {
                  setState(() {
                    _isConfirmPasswordVisible = isVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Xác nhận mật khẩu không được để trống';
                  }
                  if (value != _passwordController.text) {
                    return 'Mật khẩu xác nhận không khớp';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // --- Nút Đăng ký ---
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: const Color.fromARGB(255, 178, 31, 31),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
