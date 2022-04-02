class Setting{
  final int? id;
  final String name;
  final String pdaNo;

  Setting(
      { this.id,
        required this.name,
        required this.pdaNo});

  Setting.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        pdaNo=res["pdaNo"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name,'pdaNo':pdaNo};
  }

}