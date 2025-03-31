class DatasetModel<T> {
  int? spRtn;
  String? isScalar;
  num? rowCount;
  String? errorMsg;
  T? dataset;

  DatasetModel({
    this.spRtn,
    this.isScalar,
    this.rowCount,
    this.errorMsg,
    this.dataset,
  });

  fromJsonT(Map<String, dynamic> json) {
    return DatasetModel<T>(
      spRtn: json['sp_rtn'] ?? 0,
      rowCount: json['row_count'] ?? 0,
      errorMsg: json['error_msg'] ?? '',
      dataset: json['Dataset'] != null ? json['Dataset'] : null,
    );
  }
}
