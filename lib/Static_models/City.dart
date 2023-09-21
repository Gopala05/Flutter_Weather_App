class City{
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  //List of Cities data
  static List<City> citiesList = [

    City(
        isSelected: false,
        city: 'Agra',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Ahmedabad',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Bangalore',
        country: 'India',
        isDefault: true),

    City(
        isSelected: false,
        city: 'Bhopal',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Chandigarh',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Chennai',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Coimbatore',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Delhi',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Hyderabad',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Indore',
        country: 'India',
        isDefault: false),

    City(
        isSelected: false,
        city: 'Beijing',
        country: 'China',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Paris',
        country: 'Paris',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Rome',
        country: 'Italy',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Lagos',
        country: 'Nigeria',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Amsterdam',
        country: 'Netherlands',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Barcelona',
        country: 'Spain',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Miami',
        country: 'United States',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Vienna',
        country: 'Austria',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Berlin',
        country: 'Germany',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Toronto',
        country: 'Canada',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Brussels',
        country: 'Belgium',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Nairobi',
        country: 'Kenya',
        isDefault: false),
  ];

  //Get the selected cities
  static List<City> getSelectedCities() {
    List<City> selectedCities = City.citiesList;
    return selectedCities
        .where((city) => city.isSelected == true)
        .toList();
  }
}