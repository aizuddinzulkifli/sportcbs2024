

class Court {
  final String id;
  final String name;
  final String type;
  final double pricePerHour;
  // Add more properties as needed

  Court({
    required this.id,
    required this.name,
    required this.type,
    required this.pricePerHour,
    // Add more properties as needed
  });

  // Factory method to create a Court instance from a map
  factory Court.fromMap(Map<String, dynamic> map) {
    return Court(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      pricePerHour: map['price_per_hour'],
      // Map more properties from the map as needed
    );
  }
}
