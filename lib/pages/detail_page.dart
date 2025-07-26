import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 상세'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단 이미지
                  Image.asset(
                    item.imagePath,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(height: 16),

                  // 판매자 정보
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.seller,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(item.location, style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text('39.3°C',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold)),
                            Text('매너온도', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Divider(),
                  ),

                  // 상품 제목 & 설명
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(item.description),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40), // 하단 버튼과 거리 확보
                ],
              ),
            ),
          ),

          // 하단 고정 영역
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite_border),
                const SizedBox(width: 16),
                Text(
                  '${NumberFormat('#,###').format(item.price)}원',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('채팅하기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
