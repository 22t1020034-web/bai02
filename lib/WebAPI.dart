import 'dart:async';

class Product {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  final int? discountPercent; // Ví dụ: 29 (cho -29%)
  final String soldCount; // Ví dụ: "Đã bán 30k+"
  final bool isAd; // Quảng cáo (Tài trợ)
  final bool isMall; // Shopee Mall
  final bool isPreferred; // Yêu thích

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.discountPercent,
    required this.soldCount,
    this.isAd = false,
    this.isMall = false,
    this.isPreferred = false,
  });
}

class WebAPI {
  static Future<List<Product>> fetchProducts() async {
    // Giả lập độ trễ mạng
    await Future.delayed(const Duration(milliseconds: 1000));

    return [
      Product(
        id: '1',
        imageUrl:
            "https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lm4f3q0k7q0k34",
        name: "Áo sơn mi",
        price: 2800,
        discountPercent: 29,
        soldCount: "Đã bán 30k+",
        isPreferred: true,
      ),
      Product(
        id: '2',
        imageUrl: "https://picsum.photos/300/300?random=2",
        name: "Áo bun",
        price: 1373,
        soldCount: "Đã bán 3k+",
        isAd: true,
      ),
      Product(
        id: '3',
        imageUrl: "https://picsum.photos/300/300?random=3",
        name: "Áo nam",
        price: 3500,
        discountPercent: 9,
        soldCount: "Đã bán 6k+",
        isPreferred: true,
      ),
      Product(
        id: '4',
        imageUrl: "https://picsum.photos/300/300?random=4",
        name: "Quần nam",
        price: 15000, // 0đ giả lập free
        discountPercent: 28,
        soldCount: "Đã bán 4k+",
        isMall: true,
      ),
      Product(
        id: '5',
        imageUrl: "https://picsum.photos/300/300?random=5",
        name: "Gương để bàn trang điểm có đèn LED cảm ứng",
        price: 9975,
        discountPercent: 50,
        soldCount: "Đã bán 20k+",
        isPreferred: true,
      ),
      Product(
        id: '6',
        imageUrl: "https://picsum.photos/300/300?random=6",
        name: "Set 50 tờ giấy nến gói hoa chống nước",
        price: 45000,
        soldCount: "Đã bán 12k+",
      ),
    ];
  }
}
