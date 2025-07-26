import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';

class DetailPage extends StatefulWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Item item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  void toggleLike() {
    setState(() {
      item.isLiked = !item.isLiked;
      item.likes += item.isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, item); // item 반환
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('상품 상세'),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, item),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이미지
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
                              Text(
                                item.seller,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.location,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '39.3°C',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('매너온도', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Divider(),
                    ),

                    // 상품 정보
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(item.description),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // 하단 고정 버튼
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          (item.isLiked == true)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: item.isLiked ? Colors.pink : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text('${item.likes}'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${NumberFormat('#,###').format(item.price)}원',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), 
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('채팅하기'),
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
