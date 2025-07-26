import 'package:apple_market/pages/home_page/widgets/item_card.dart';
import 'package:apple_market/pages/home_page/widgets/scroll_to_top_button.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';
import '../../data/csv_loader.dart';
import '../detail_page/detail_page.dart';

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
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('르탄동'),
        ),
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
      body: _items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
                return ItemCard(
                  item: item,
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
                );
              },
            ),
      floatingActionButton: ScrollToTopButton(
        show: _showFab,
        isPressed: _isPressed,
        onTap: _scrollToTop,
      ),
    );
  }
}
