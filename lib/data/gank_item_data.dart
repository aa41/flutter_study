class GankItemData {
  String id;

  String createAt;

  String desc;

  String url;

  List<dynamic> images;

  GankItemData(this.id, this.createAt, this.desc, this.url, this.images);

  factory GankItemData.fromJson(Map<String,dynamic> map) {
    return GankItemData(
        map["_id"], map["createAt"], map["desc"], map["url"], map["images"]);
  }
}
