

import 'package:dgi/db/CountryRepository.dart';
import 'package:dgi/model/country.dart';

class CountryService{
  CountryRepository countryRepository = CountryRepository();
  Future<int> insert(Country country) async {
    return countryRepository.insert(country);
  }
  Future<List<Country>> retrieve() async {
    return countryRepository.retrieve();
  }
  Future<int> batch(List<Country> countries) async {
    return countryRepository.batch(countries);
  }
  Future<void> delete(int id) async {
    return countryRepository.delete(id);
  }
}