class Users {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String imageUrl;
  String phoneNumber;

  Users(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.imageUrl,
      this.phoneNumber});

  Users.fromData(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    imageUrl = json['imageUrl'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imageUrl'] = this.imageUrl;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
