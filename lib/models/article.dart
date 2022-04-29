class Article {
  List<Data>? data;
  int? statusCode;

  Article({this.data, this.statusCode});

  Article.fromJson(Map<String, dynamic> json, status) {
    statusCode = status;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? author;
  String? title;
  String? description;
  String? url;
  String? source;
  String? image;
  String? category;
  String? language;
  String? country;
  String? publishedAt;

  Data(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.source,
      this.image,
      this.category,
      this.language,
      this.country,
      this.publishedAt});

  Data.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    source = json['source'];
    image = json['image'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['source'] = this.source;
    data['image'] = this.image;
    data['category'] = this.category;
    data['language'] = this.language;
    data['country'] = this.country;
    data['published_at'] = this.publishedAt;
    return data;
  }
}
