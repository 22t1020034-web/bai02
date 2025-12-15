import 'package:flutter/material.dart';

class PhanHoiForm extends StatefulWidget {
  const PhanHoiForm({super.key});

  @override
  State<PhanHoiForm> createState() => _PhanHoiFormState();
}

class _PhanHoiFormState extends State<PhanHoiForm> {
  final _formKey = GlobalKey<FormState>();

  String? hoTen;
  int? danhGia;
  String? noiDung;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gửi phản hồi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 199, 17, 154),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Họ tên
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Họ tên",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập họ tên" : null,
                onSaved: (value) => hoTen = value,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: "Đánh giá (1 – 5 sao)",
                  border: OutlineInputBorder(),
                ),
                items: List.generate(
                  5,
                  (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text("${i + 1} sao"),
                  ),
                ),
                onChanged: (value) => danhGia = value,
                validator: (value) =>
                    value == null ? "Vui lòng chọn sao" : null,
              ),
              const SizedBox(height: 16),

              // Nội dung góp ý
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Nội dung góp ý",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập góp ý" : null,
                onSaved: (value) => noiDung = value,
              ),
              const SizedBox(height: 20),

              // Nút gửi phản hồi
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 113, 153),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Gửi phản hồi thành công!"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Gửi phản hồi",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
