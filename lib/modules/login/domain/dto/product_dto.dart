class ProductDTO {
  final String id;
  final String title;
  final String thumbnail;

  ProductDTO({required this.id, required this.title, required this.thumbnail});

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      id: json['id'].toString(),
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }
}
