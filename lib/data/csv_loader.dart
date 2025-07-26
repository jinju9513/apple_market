import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/item.dart';

Future<List<Item>> loadItemsFromCsv() async {
  final rawData = await rootBundle.loadString('assets/data/items.csv');
  final csvData = const CsvToListConverter().convert(rawData, eol: '\n');

  // 헤더 제거 (1행은 컬럼명 아님)
  final data = csvData.sublist(1);

  return data.map((row) {
    return Item(
      title: row[2].toString(),
      description: row[3].toString().replaceAll('\\n', ' '),
      imagePath: 'assets/images/${row[1]}.png',
      seller: row[4].toString(),
      price: int.tryParse(row[5].toString()) ?? 0,
      location: row[6].toString(),
      likes: int.tryParse(row[7].toString()) ?? 0,
      chats: int.tryParse(row[8].toString()) ?? 0,
    );
  }).toList();
}
