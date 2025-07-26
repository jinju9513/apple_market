import 'package:apple_market/pages/detail_page/widgets/bottom_bar.dart';
import 'package:apple_market/pages/detail_page/widgets/product_content.dart';
import 'package:apple_market/pages/detail_page/widgets/product_image.dart';
import 'package:apple_market/pages/detail_page/widgets/seller_info.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';

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
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, item);
        }
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
                    ProductImage(imagePath: item.imagePath),
                    const SizedBox(height: 16),
                    SellerInfo(seller: item.seller, location: item.location),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Divider(),
                    ),
                    ProductContent(
                      title: item.title,
                      description: item.description,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            BottomBar(item: item, onLikePressed: toggleLike),
          ],
        ),
      ),
    );
  }
}
