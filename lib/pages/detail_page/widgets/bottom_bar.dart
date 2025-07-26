import 'package:apple_market/models/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomBar extends StatelessWidget {
  final Item item;
  final VoidCallback onLikePressed;

  const BottomBar({super.key, required this.item, required this.onLikePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onLikePressed,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                item.isLiked ? Icons.favorite : Icons.favorite_border,
                color: item.isLiked ? Colors.pink : Colors.grey,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '${NumberFormat('#,###').format(item.price)}원',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
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
    );
  }
}