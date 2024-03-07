// // To parse this JSON data, do
// //
// //     final linksRecordModel = linksRecordModelFromJson(jsonString);
//
// import 'dart:convert';
//
// LinksRecordModel linksRecordModelFromJson(String str) => LinksRecordModel.fromJson(json.decode(str));
//
// String linksRecordModelToJson(LinksRecordModel data) => json.encode(data.toJson());
//
// class LinksRecordModel {
//   String? title;
//   String? url;
//
//   LinksRecordModel({
//     this.title,
//     this.url,
//   });
//
//   factory LinksRecordModel.fromJson(Map<String, dynamic> json) => LinksRecordModel(
//     title: json["title"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "url": url,
//   };
// }

class LinksRecordModel {
  final int id;
  final String imagePath;
  final String title;
  final String url;

  LinksRecordModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.url,
  });

  factory LinksRecordModel.fromJson(Map<dynamic, dynamic> json) {
    final id = json.keys.first;
    final data = json[id] as Map<dynamic, dynamic>;
    return LinksRecordModel(
      id: int.parse(id.toString()),
      imagePath: data['imagePath'] as String,
      title: data['title'] as String,
      url: data['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      id.toString(): {
        'imagePath': imagePath,
        'title': title,
        'url': url,
      },
    };
  }
}
