class UserModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final Name? name;
  final Address? address;
  final String? phone;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.name,
    this.address,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'name': name?.toJson(),
      'address': address?.toJson(),
      'phone': phone,
    };
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  String get fullName => '$firstname $lastname';
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final Geolocation? geolocation;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      number: json['number'] ?? 0,
      zipcode: json['zipcode'] ?? '',
      geolocation: json['geolocation'] != null
          ? Geolocation.fromJson(json['geolocation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': geolocation?.toJson(),
    };
  }
}

class Geolocation {
  final String lat;
  final String long;

  Geolocation({
    required this.lat,
    required this.long,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: json['lat'] ?? '',
      long: json['long'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}

