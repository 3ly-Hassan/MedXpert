class Review {
  String? drugId;
  String? userId;
  String? review;
  String? rating;

  Review({
    this.drugId,
    this.userId,
    this.review,
    this.rating,
  });

  Review.fromJson(Map<String, dynamic> json) {
    drugId = json['drug_id'];
    userId = json['user_id'];
    review = json['review'];
    rating = json['rating'];
  }
}
