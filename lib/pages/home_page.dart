import 'package:apple_market/pages/detail_page.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;
  bool _isPressed = false;
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    itemsFuture = loadItemsFromCsv().then((data) {
      setState(() => _items = data);
      return data;
    });

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset > 10 && !_showFab) {
        setState(() => _showFab = true);
      } else if (offset <= 10 && _showFab) {
        setState(() => _showFab = false);
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    setState(() => _isPressed = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isPressed = false);
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('상품 삭제'),
        content: const Text('이 상품을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _items.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(alignment: Alignment.centerLeft, child: Text('르탄동')),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('알림이 없습니다.')));
            },
          ),
        ],
      ),
      body: _items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
                return GestureDetector(
                  onTap: () async {
                    final updatedItem = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailPage(item: item)),
                    );
                    if (updatedItem != null) {
                      setState(() {
                        _items[index] = updatedItem;
                      });
                    }
                  },
                  onLongPress: () => _confirmDelete(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.asset(
                            item.imagePath,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.location,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${NumberFormat('#,###').format(item.price)} 원',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.chat_bubble_outline,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('${item.chats}'),
                                      const SizedBox(width: 8),
                                      Icon(
                                        item.isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: item.isLiked
                                            ? Colors.pink
                                            : Colors.grey,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text('${item.likes}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showFab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: _showFab
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 4,
                onPressed: _scrollToTop,
                child: Icon(
                  _isPressed ? Icons.check : Icons.arrow_upward,
                  color: Colors.grey[800],
                ),
              )
            : null,
      ),
    );
  }
}
