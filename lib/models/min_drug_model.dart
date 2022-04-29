class MinDrugModel {
  String? drugName;
  String? drugId;
  MinDrugModel(this.drugName, this.drugId);

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
