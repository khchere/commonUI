/// sp_rtn : 0
/// is_scalar : "N"
/// row_count : 26058
/// error_msg : ""
/// Dataset : [{},{}]

class DatasetListModel<T> {
  int? spRtn;
  String? isScalar;
  num? rowCount;
  String? errorMsg;
  List<T>? dataset;

  DatasetListModel({
    this.spRtn,
    this.isScalar,
    this.rowCount,
    this.errorMsg,
    this.dataset,
  });

  // JSON → DatasetListModel<T> 변환
  factory DatasetListModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return DatasetListModel<T>(
      spRtn: json['sp_rtn'] ?? 0,
      rowCount: json['row_count'] ?? 0,
      errorMsg: json['error_msg'] ?? '',
      dataset: json['Dataset'] != null
          ? (json['Dataset'] as List).map((item) => fromJsonT(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    final map = <String, dynamic>{};
    map['sp_rtn'] = spRtn;
    map['is_scalar'] = isScalar;
    map['row_count'] = rowCount;
    map['error_msg'] = errorMsg;
    if (dataset != null) {
      map['Dataset'] = dataset?.map((item) => toJsonT(item)).toList();
    }
    return map;
  }
}
