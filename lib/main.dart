import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<CountriesStat> fetchAlbum(http.Client client) async {
  final response = await client.get(
      Uri.parse('https://corona-virus-world-and-india-data.p.rapidapi.com/api'),
      headers: {
        'x-rapidapi-host': 'corona-virus-world-and-india-data.p.rapidapi.com',
        'x-rapidapi-key': '6b43206931mshf9b4796cc4700afp139455jsned3f9fd23fa0',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CountriesStat.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an except
    throw Exception('Failed to load album');
  }
}

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   const Album({required this.userId, required this.id, required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

class CountriesStat {
  String? countryName;
  String? cases;
  String? deaths;
  String? region;
  String? totalRecovered;
  String? newDeaths;
  String? newCases;
  String? seriousCritical;
  String? activeCases;
  String? totalCasesPer1mPopulation;
  String? deathsPer1mPopulation;
  String? totalTests;
  String? testsPer1mPopulation;

  CountriesStat(
      {this.countryName,
      this.cases,
      this.deaths,
      this.region,
      this.totalRecovered,
      this.newDeaths,
      this.newCases,
      this.seriousCritical,
      this.activeCases,
      this.totalCasesPer1mPopulation,
      this.deathsPer1mPopulation,
      this.totalTests,
      this.testsPer1mPopulation});

  CountriesStat.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    cases = json['cases'];
    deaths = json['deaths'];
    region = json['region'];
    totalRecovered = json['total_recovered'];
    newDeaths = json['new_deaths'];
    newCases = json['new_cases'];
    seriousCritical = json['serious_critical'];
    activeCases = json['active_cases'];
    totalCasesPer1mPopulation = json['total_cases_per_1m_population'];
    deathsPer1mPopulation = json['deaths_per_1m_population'];
    totalTests = json['total_tests'];
    testsPer1mPopulation = json['tests_per_1m_population'];
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<CountriesStat> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<CountriesStat>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.countryName.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
