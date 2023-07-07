class Host {
  static var host = 'http://192.168.8.102:3366';
  // static var host = 'https://bw-image.000webhostapp.com';

  Uri baseUrl({String? endpoint}) => Uri.parse("$host/api/$endpoint");
  String baseUrl2({String? endpoint}) => "$host/api/$endpoint";
  String imageUrl() => "$host/";

  Map<String, String> headers(String bearer) =>
      {"Accept": "application/json", "Authorization": "Bearer $bearer"};
}
