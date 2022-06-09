class Subs {
  final String tag;
  final String duration;
  final int price;
  final String location;
  final String radius;
  final String crowd;
  final String hours;
  final String get;
  final String tracking;
  Subs({
    required this.tag,
    required this.duration,
    required this.price,
    required this.location,
    required this.radius,
    required this.crowd,
    required this.hours,
    required this.get,
    required this.tracking,
  });
}

List<Subs> subsList = [
  Subs(
      tag: 'Best Price',
      duration: 'Yearly',
      price: 199,
      location: 'Multiple Location',
      radius: 'Upto 500km radius',
      crowd: 'Highly crowded Areas',
      hours: 'Upto 3000 hours active time',
      get: 'Get Functions & statisticcs',
      tracking: 'Live Tracking'),
  Subs(
      tag: 'Affordable',
      duration: 'Monthly',
      price: 19,
      location: 'Selected Location',
      radius: 'Upto 100km radius',
      crowd: 'Crowded Areas',
      hours: 'Upto 250 hours active time',
      get: 'Get Functions & statisticcs',
      tracking: 'Live Tracking'),
  Subs(
      tag: 'Trial',
      duration: 'Weekly',
      price: 1,
      location: 'One Location',
      radius: 'Upto 10km radius',
      crowd: 'Limited Audience',
      hours: 'Upto 40 hours active time',
      get: 'Get statisticcs',
      tracking: 'Live Tracking'),
];
