class CityModel {
  CityModel({
      this.name, 
      this.lat, 
      this.lon, 
      this.country, 
      this.state,});

  CityModel.fromJson(dynamic json) {
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }
  String? name;
  num? lat;
  num? lon;
  String? country;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['lat'] = lat;
    map['lon'] = lon;
    map['country'] = country;
    map['state'] = state;
    return map;
  }

}