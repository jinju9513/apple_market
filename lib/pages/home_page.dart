import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';
import '../data/csv_loader.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Item>> itemsFuture;

  @override
  void initState() {
    super.initState();
    itemsFuture = loadItemsFromCsv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('르탄동'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('알림이 없습니다.')),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('상품이 없습니다.'));
          }

          final items = snapshot.data!;
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.location),
                    Text(
                      '${NumberFormat('#,###').format(item.price)}원',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                onTap: () {
                  // TODO: 상세페이지로 이동
                },
              );
            },
          );
        },
      ),
    );
  }
}
