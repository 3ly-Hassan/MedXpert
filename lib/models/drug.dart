class Drug {
  String? id;
  String? incId;
  String? drugName;
  String? category;
  String? indicationofuse;
  String? description;
  double? price;
  double? overdose;
  String? more;
  List<dynamic>? interactions;
  List<dynamic>? restrictions;
  String? createdAt;
  String? updatedAt;

  Drug({
    this.id,
    this.incId,
    this.drugName,
    this.category,
    this.indicationofuse,
    this.description,
    this.price,
    this.overdose,
    this.more,
    this.interactions,
    this.restrictions,
    this.createdAt,
    this.updatedAt,
  });

  Drug.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    incId = json['Inc_id'];
    drugName = json['drugName'];
    category = json['category'];
    indicationofuse = json['indicationofuse'];
    description = json['description'];
    price = json['price'];
    overdose = json['overdose'];
    more = json['more'];
    interactions = json['interactions'];
    restrictions = json['restrictions'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }


}
