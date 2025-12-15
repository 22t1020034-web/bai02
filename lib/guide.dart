import 'package:flutter/material.dart';

class guide extends StatelessWidget {
  const guide({super.key});
  Widget _buildPlaceCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.notifications_none_rounded, size: 28),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                'Welcome,',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Charlie',
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Saved Places',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    _buildPlaceCard('assets/Anh1.PNG'),
                    _buildPlaceCard('assets/ANH2.png'),
                    _buildPlaceCard('assets/ANH3.png'),
                    _buildPlaceCard('assets/ANH4.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
