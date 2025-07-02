interface class MainPageLoc {
  final String title = '';
  final String btnCustomer = '';
  final String btnAirplane = '';
  final String btnFlights = '';
  final String btnReservation = '';
  final String footer = '';
}

class MainPageEN implements MainPageLoc {
  @override
  final String title = 'GroupProject S25';

  @override
  final String btnCustomer = 'Customer List';

  @override
  final String btnAirplane = 'Airplane List';

  @override
  final String btnFlights = 'Flights List';

  @override
  final String btnReservation = 'Reservation List';

  @override
  final String footer = '@Algonquin College, CST2335 Final.';
}

class MainPageFR implements MainPageLoc {
  @override
  final String title = 'Projet De Groupe S25';

  @override
  final String btnCustomer = 'Liste Des Clients';

  @override
  final String btnAirplane = 'Liste Des Avions';

  @override
  final String btnFlights = 'Liste Des Vols';

  @override
  final String btnReservation = 'Liste De Réservation';

  @override
  final String footer = '@Collège Algonquin, CST2335 Finale.';
}