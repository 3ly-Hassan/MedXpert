class Words {
  String? imgName;
  List<Data>? data;

  Words({this.imgName, this.data});

  Words.fromJson(Map<String, dynamic> json) {
    imgName = json['imgName'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgName'] = this.imgName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Vertices>? vertices;
  List<String>? names;

  Data({this.vertices, this.names});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vertices'] != null) {
      vertices = <Vertices>[];
      json['vertices'].forEach((v) {
        vertices!.add(new Vertices.fromJson(v));
      });
    }
    names = json['names'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vertices != null) {
      data['vertices'] = this.vertices!.map((v) => v.toJson()).toList();
    }
    data['names'] = this.names;
    return data;
  }
}

class Vertices {
  int? x;
  int? y;

  Vertices({this.x, this.y});

  Vertices.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
