class KhaltiError {
  String action;
  Map<String, dynamic> errorMap;

  KhaltiError({
    required this.action,
    required this.errorMap,
  });

  factory KhaltiError.fromJson(Map<String, dynamic> json) {
    return KhaltiError(
      action: json['action'],
      errorMap: json['errorMap'] != null
          ? Map<String, dynamic>.from(json['errorMap'])
          : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "action": this.action,
      "errorMap": this.errorMap,
    };
  }
}
