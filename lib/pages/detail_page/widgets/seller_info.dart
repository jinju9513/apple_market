import 'package:flutter/material.dart';

class SellerInfo extends StatelessWidget {
  final String seller;
  final String location;

  const SellerInfo({super.key, required this.seller, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.deepOrangeAccent,
            radius: 20,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(seller, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(location, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('39.3°C', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
              Text('매너온도', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}