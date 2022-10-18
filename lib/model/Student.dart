class Student {
  final int id;
  final String user_id;
  final String name;
  final String email;
  final String contact;
  final String occuption;
  final String gender;
  final String pic;
  final String status;

  Student({
    required this.id,
    required this.user_id,
    required this.name,
    required this.email,
    required this.contact,
    required this.occuption,
    required this.gender,
    required this.pic,
    required this.status,
  });


  factory Student.fromMap(Map<String, dynamic> json) => Student(
    id: json["id"],
    user_id: json["user_id"] ?? "",
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    contact: json["contact"] ?? "",
    occuption: json["occuption"] ?? "",
    gender: json["gender"] ?? "",
    status: json["status"] ?? "",
    pic: json["pic"] ?? "",
  );


  Map<String, dynamic> toMap() => {
        "user_id": user_id,
        "name": name,
        "email": email,
        "contact": contact,
        "occuption": occuption,
        "gender": gender,
        "pic": pic,
        "status": status
      };

  static const String TABLE_NAME = "student";
  static const String COLUMN_ID = "id";
  static const String COLUMN_USER_ID = "user_id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_CONTACT = "contact";
  static const String COLUMN_OCCUPTION = "occuption";
  static const String COLUMN_GENDER = "gender";
  static const String COLUMN_PIC = "pic";
  static const String COLUMN_STATUS = "status";

  static const String createTable = "CREATE TABLE $TABLE_NAME ( "
      "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
      "$COLUMN_USER_ID TEXT, "
      "$COLUMN_NAME TEXT, "
      "$COLUMN_EMAIL TEXT, "
      "$COLUMN_CONTACT TEXT, "
      "$COLUMN_GENDER TEXT, "
      "$COLUMN_STATUS TEXT, "
      "$COLUMN_PIC TEXT, "
      "$COLUMN_OCCUPTION TEXT )";
}
