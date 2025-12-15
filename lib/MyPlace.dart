import 'package:flutter/material.dart';

void main() {
  runApp(const MyPlace());
}

class MyPlace extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            block1(),
            block2(),
            const Divider(thickness: 1, indent: 20, endIndent: 20),
            block3(),
            const Divider(thickness: 1, indent: 20, endIndent: 20),
            block4(),
          ],
        ),
      ),
    );
  }

  const MyPlace({super.key});
  Widget block1() {
    var src =
        "https://cdn.pixabay.com/photo/2025/11/11/05/51/05-51-54-693_1280.jpg";

    return Image.network(src);
  }

  Widget block2() {
    var title = "Tệ nạn xã hội";
    var subtitle = "Tình trạng phổ biến ở Việt Nam";
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                subtitle,
                style: TextStyle(color: const Color.fromARGB(255, 71, 19, 93)),
              ),
            ],
          ),

          Row(
            children: const [
              Icon(Icons.star, color: Color.fromARGB(255, 71, 5, 58)),
              SizedBox(width: 5),
              Text("30"),
            ],
          ),
        ],
      ),
    );
  }

  Widget block3() {
    Widget buildButton(IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 147, 207, 35)),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: Colors.blue)),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButton(Icons.call, 'CALL'),
          buildButton(Icons.near_me, 'ROUTE'),
          buildButton(Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Widget block4() {
    var data =
        "Tệ nạn xã hội - một bóng ma đang len lỏi vào từng ngõ ngách cuộc sống, từ những con đường phố thị đến môi trường học đường trong lành, gây ra những hậu quả khôn lường. Chúng ta có thể thấy rõ sức tàn phá của ma túy cướp đi sinh mạng, cờ bạc bòn rút tài sản và hạnh phúc, hay nghiện game online làm suy đồi đạo đức, biến giới trẻ thành những con người vô hồn, mất phương hướng. Hậu quả không chỉ dừng lại ở bản thân mỗi người với sức khỏe suy kiệt, tương lai mờ mịt, mà còn lan tới gia đình, xé nát tình thương, đẩy cha mẹ vào bi kịch, con cái vào cảnh bơ vơ. Ở phạm vi rộng hơn, tệ nạn xã hội làm gia tăng tội phạm, bất ổn an ninh trật tự, và làm suy yếu nòi giống, cản trở sự tiến bộ của đất nước. Để đẩy lùi căn bệnh xã hội này, cần sự chung tay của tất cả mọi người: mỗi cá nhân tự trang bị kiến thức, lối sống lành mạnh; gia đình quan tâm, giáo dục con cái; nhà trường tổ chức hoạt động bổ ích; và pháp luật cần có những biện pháp mạnh mẽ để ngăn chặn. Chỉ khi mỗi chúng ta nói không với tệ nạn, xã hội mới thực sự trong lành và phát triển. ";
    return Padding(padding: const EdgeInsets.all(20.0), child: Text(data));
  }
}
