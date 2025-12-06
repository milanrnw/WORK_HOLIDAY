import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_holiday/providers/country_provider.dart';
import 'package:work_holiday/widgets/country_card.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CountryProvider>().fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TOP COUNTRIES"),
      ),
      body: Consumer<CountryProvider>(
        builder: (context, value, child) {
          final isLoading = value.isLoading;
          final countryData = value.countriesData;

          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (countryData == null || countryData.countries.isEmpty)
                  ? const Center(
                      child: Text("No data found"),
                    )
                  : ListView.builder(
                      itemCount: countryData.countries.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CountryCard(
                              index: index,
                              country: value.countriesData!.countries[index]),
                        );
                      },
                    );
        },
      ),
    );
  }
}
