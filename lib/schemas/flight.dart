import 'package:floor/floor.dart';

@Entity(
  tableName: 'flights',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['fromCity']),
    Index(value: ['toCity']),
    Index(value: ['fromCity', 'toCity']),
    Index(value: ['model']),
  ],
)
class Flight {
  final String id;
  final String flightCode;
  final String fromCity;
  final String toCity;
  final String departureTime;
  final String arrivalTime;
  final String model;

  Flight({
    required this.id,
    required this.flightCode,
    required this.fromCity,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.model,
  });
}

@dao
abstract class FlightDAO {
  @Query('SELECT * FROM flights')
  Future<List<Flight>> listFlights();

  @Query('SELECT * FROM flights WHERE id = :id')
  Future<Flight?> getFlightById(String id);

  @Update()
  Future<void> updateFlight(Flight flight);

  @insert
  Future<void> insertFlight(Flight flight);

  @delete
  Future<void> deleteFlight(Flight flight);
}