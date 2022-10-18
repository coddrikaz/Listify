class User {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final String username;
  final String password;

  User(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.email,
      required this.username,
      required this.password});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"] ?? "",
      mobile: json["mobile"] ?? "",
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      password: json["password"] ?? "",
  );

  Map<String, dynamic> toMap() =>{
    "id" : id,
    "name" : name,
    "mobile" : mobile,
    "email" : email,
    "username" : username,
    "password" : password,
  };

  static const String TABLE_NAME = "user";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_MOBILE = "mobile";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_USERNAME= "username";
  static const String COLUMN_PASSWORD = "password";

  static const String createTable = "CREATE TABLE $TABLE_NAME ( "
      "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
      "$COLUMN_NAME TEXT, "
      "$COLUMN_MOBILE TEXT, "
      "$COLUMN_EMAIL TEXT, "
      "$COLUMN_USERNAME TEXT, "
      "$COLUMN_PASSWORD TEXT )";
}
