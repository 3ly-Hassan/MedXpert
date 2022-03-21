class Review {
  String? id;
  String? drugId;
  String? userId;
  String? review;
  String? rating;

  Review({
    this.id,
    this.drugId,
    this.userId,
    this.review,
    this.rating,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    drugId = json['drug_id'];
    userId = json['user_id'];
    review = json['review'];
    rating = json['rating'];
  }
}
