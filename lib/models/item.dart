class Item {
  final String title;         // 상품명
  final String description;   // 상품 설명
  final String imagePath;     // 이미지 경로
  final String seller;        // 판매자
  final int price;            // 가격
  final String location;      // 거래 지역
  final int likes;            // 좋아요 수
  final int chats;            // 채팅 수

  Item({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.seller,
    required this.price,
    required this.location,
    required this.likes,
    required this.chats,
  });
}
