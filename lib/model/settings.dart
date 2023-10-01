class Setting{
  final int? id;
  final String pdaNo;
  final String ipAddress;

  Setting(
      { this.id,
        required this.pdaNo,
        required this.ipAddress});

  Setting.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        pdaNo=res["pdaNo"],
        ipAddress = res["ipAddress"];

  Map<String, Object?> toMap() {
    return {'id':id,'pdaNo':pdaNo,'ipAddress':ipAddress};
  }

}