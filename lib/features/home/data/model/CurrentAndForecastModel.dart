import 'Current.dart';
import 'Minutely.dart';
import 'Hourly.dart';
import 'Daily.dart';

class CurrentAndForecastModel {
  CurrentAndForecastModel({
      this.lat, 
      this.lon, 
      this.timezone, 
      this.timezoneOffset, 
      this.current, 
      this.minutely, 
      this.hourly, 
      this.daily,});

  CurrentAndForecastModel.fromJson(dynamic json) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
    if (json['minutely'] != null) {
      minutely = [];
      json['minutely'].forEach((v) {
        minutely?.add(Minutely.fromJson(v));
      });
    }
    if (json['hourly'] != null) {
      hourly = [];
      json['hourly'].forEach((v) {
        hourly?.add(Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily?.add(Daily.fromJson(v));
      });
    }
  }
  num? lat;
  num? lon;
  String? timezone;
  num? timezoneOffset;
  Current? current;
  List<Minutely>? minutely;
  List<Hourly>? hourly;
  List<Daily>? daily;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lon'] = lon;
    map['timezone'] = timezone;
    map['timezone_offset'] = timezoneOffset;
    if (current != null) {
      map['current'] = current?.toJson();
    }
    if (minutely != null) {
      map['minutely'] = minutely?.map((v) => v.toJson()).toList();
    }
    if (hourly != null) {
      map['hourly'] = hourly?.map((v) => v.toJson()).toList();
    }
    if (daily != null) {
      map['daily'] = daily?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}