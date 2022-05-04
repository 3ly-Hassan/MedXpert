class MinDrugModel {
  String? drugName;
  String? drugId;
  MinDrugModel(
      [this.drugName = 'default drug name', this.drugId = 'default drug Id']);

  MinDrugModel.fromJson(Map<String, dynamic> json) {
    drugName = json['name'];
    drugId = json['id'];
  }

  Map<String, dynamic> toJson() {
    dynamic data = {};
    data['name'] = drugName;
    data['id'] = drugId;
    return data;
  }
}
