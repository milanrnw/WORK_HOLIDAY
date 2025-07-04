import 'package:flutter/material.dart';
import 'package:work_holiday/core/api_requests.dart';
import 'package:work_holiday/models/country/country_main_model.dart';
import 'package:http/http.dart' as http;
import 'package:work_holiday/widgets/country_card.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  bool isLoading = false;
  late CountryMainModel countriesData;

  Future<void> fetchCountries() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(ApiRequests.countriesUrl));

    if (response.statusCode == 200) {
      countriesData = countryMainModelFromJson(response.body);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Oops! Something went wrong"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TOP COUNTRIES"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (countriesData.countries.isEmpty)
              ? const Center(
                  child: Text("No countries found"),
                )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: countriesData.countries.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CountryCard(
                            index: index, country: countriesData.countries[index]),
                      );
                    },
                  ),
              ),
    );
  }
}
