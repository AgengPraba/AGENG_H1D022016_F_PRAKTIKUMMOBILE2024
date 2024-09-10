import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() async {
  stdout.write('Enter a domain name: ');
  String? hostname = stdin.readLineSync();

  if (hostname != null) {
    try {
      var addresses = await InternetAddress.lookup(hostname);
      String ipAddress = addresses.first.address;

      String requestUrl = 'https://geolocation-db.com/jsonp/$ipAddress';

      // Mengirim request HTTP GET
      var response = await http.get(Uri.parse(requestUrl));

      // Mengolah response untuk mengambil data geolocation
      String geolocation = response.body;
      geolocation = geolocation.split('(')[1].trim().replaceAll(')', '');
      Map<String, dynamic> geolocationData = jsonDecode(geolocation);

      //Cetak hasil
      geolocationData.forEach((key, value) {
        print('$key : $value');
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
