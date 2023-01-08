class User {
  String? username;
  String? password;
  String? job;

  User(this.username, this.password, this.job);

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['job'] = this.job;
    return data;
  }
}
