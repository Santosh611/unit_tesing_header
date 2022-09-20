import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_header/main.dart';
import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(
          Uri.parse(
              'https://corona-virus-world-and-india-data.p.rapidapi.com/api'),
          headers: {
            'x-rapidapi-host':
                'corona-virus-world-and-india-data.p.rapidapi.com',
            'x-rapidapi-key':
                '6b43206931mshf9b4796cc4700afp139455jsned3f9fd23fa0',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          })).thenAnswer((_) async => http.Response('{""}', 200));

      // "country_name": "USA", "cases": "82,649,779", "deaths": "1,018,316","regions":"","total_recovered":"80",434,925","new_deaths": "0","new_cases":"0","serious_critical":"1,465","active_cases":"1,196,538","total_cases_per_1m_population":"247,080","deaths_per_1m_population":"3,044","total_tests":"1,000,275,726","total_tests":"1,000,275,726","tests_per_1m_population":"2,990,303"

      expect(await fetchAlbum(client), isA<CountriesStat>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
