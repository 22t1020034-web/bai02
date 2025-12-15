import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/model/product.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  String selectedCategory = "Tất cả";
  List<Product> cart = []; // Giỏ hàng lưu tạm

  String convertCategory(String cat) {
    if (cat.contains("electronics")) return "Điện tử";
    if (cat.contains("jewel")) return "Trang sức";
    return "Tất cả";
  }

  final Map<String, String> vietShortDesc = {
    "Smartphone XYZ": "Điện thoại màn hình lớn, pin khỏe...",
    "Diamond Ring": "Nhẫn vàng 18k đính kim cương...",
    "Laptop ABC": "Laptop mạnh mẽ, RAM 16GB, SSD 512GB...",
    "Headphones": "Tai nghe chống ồn, pin lâu...",
  };

  final Map<String, String> vietDetailDesc = {
    "Smartphone XYZ":
        "Điện thoại Smartphone XYZ với màn hình 6.5 inch, camera 48MP, pin 4000mAh, thiết kế sang trọng và hiệu năng mạnh mẽ.",
    "Diamond Ring":
        "Nhẫn kim cương Diamond Ring làm từ vàng 18k, thiết kế tinh xảo, phù hợp làm quà tặng hoặc trang sức cao cấp.",
    "Laptop ABC":
        "Laptop ABC 15.6 inch Full HD, RAM 16GB, SSD 512GB, pin lâu, thích hợp cho học tập và công việc.",
    "Headphones":
        "Tai nghe Headphones không dây, chống ồn chủ động, pin 20 giờ, âm thanh sống động và thoải mái khi sử dụng lâu.",
  };

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã thêm ${product.title} vào giỏ hàng!")),
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartPage(cart: cart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Lazada", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 137, 203, 4),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: openCart,
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: const Color.fromARGB(255, 41, 9, 223),
                      child: Text(
                        "${cart.length}",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Container(
            color: const Color.fromARGB(255, 55, 21, 178),
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm sản phẩm...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CATEGORY BAR
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TopCategory(
                  icon: Icons.home,
                  label: "Tất cả",
                  active: selectedCategory == "Tất cả",
                  onTap: () => setState(() => selectedCategory = "Tất cả"),
                  activeColor: const Color.fromARGB(255, 30, 83, 182),
                ),
                _TopCategory(
                  icon: Icons.devices,
                  label: "Điện tử",
                  active: selectedCategory == "Điện tử",
                  onTap: () => setState(() => selectedCategory = "Điện tử"),
                  activeColor: const Color.fromARGB(255, 17, 57, 158),
                ),
                _TopCategory(
                  icon: Icons.diamond,
                  label: "Trang sức",
                  active: selectedCategory == "Trang sức",
                  onTap: () => setState(() => selectedCategory = "Trang sức"),
                  activeColor: const Color.fromARGB(255, 35, 17, 127),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // PRODUCT GRID
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: testAPI.getAllProduct(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snap.hasData || snap.data!.isEmpty) {
                  return const Center(child: Text("Không có dữ liệu"));
                }

                var products = snap.data!;
                if (selectedCategory != "Tất cả") {
                  products = products
                      .where(
                        (p) => convertCategory(p.category) == selectedCategory,
                      )
                      .toList();
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(6),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductGridItem(
                      product: product,
                      vietShortDescription:
                          vietShortDesc[product.title] ?? "Mô tả ngắn",
                      vietDetailDescription:
                          vietDetailDesc[product.title] ?? "Mô tả chi tiết",
                      onAddToCart: () => addToCart(product),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// GRID ITEM
class ProductGridItem extends StatelessWidget {
  final Product product;
  final String vietShortDescription;
  final String vietDetailDescription;
  final VoidCallback onAddToCart;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.vietShortDescription,
    required this.vietDetailDescription,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetail(
            product: product,
            vietDescription: vietDetailDescription,
            onAddToCart: onAddToCart,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 0.6),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Container(
              height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) =>
                    Container(color: Colors.grey[200]),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.2,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              vietShortDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black54,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${product.price} đ",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 106, 193, 7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PRODUCT DETAIL
class ProductDetail extends StatelessWidget {
  final Product product;
  final String vietDescription;
  final VoidCallback onAddToCart;

  const ProductDetail({
    super.key,
    required this.product,
    required this.vietDescription,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.image,
              height: 260,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) =>
                  Container(height: 260, color: Colors.grey[200]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.price} đ",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 125, 6, 139),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    vietDescription,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onAddToCart,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Thêm vào giỏ hàng"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 54, 21, 219),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CART PAGE
class CartPage extends StatelessWidget {
  final List<Product> cart;
  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        backgroundColor: const Color.fromARGB(255, 243, 11, 247),
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Giỏ hàng trống"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.network(
                    item.image,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(item.title),
                  subtitle: Text("${item.price} đ"),
                );
              },
            ),
    );
  }
}

// CATEGORY BUTTON
class _TopCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final Color activeColor;

  const _TopCategory({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: active ? activeColor : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: active ? Colors.white : Colors.black54,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              color: active ? activeColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
