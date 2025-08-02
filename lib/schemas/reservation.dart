import 'package:floor/floor.dart';

@Entity(
  tableName: 'reservations',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['customerId']),
    Index(value: ['flightCode']),
    Index(value: ['flightDate']),
  ],
)
class Reservation {
  final String id;
  final String note;
  final String customerId;
  final String flightCode;
  final String flightDate;

  Reservation({
    required this.id,
    required this.note,
    required this.customerId,
    required this.flightCode,
    required this.flightDate,
  });
}

@dao
abstract class ReservationDAO {
  @Query('SELECT * FROM reservations')
  Future<List<Reservation>> listReservations();

  @Query('SELECT * FROM reservations WHERE id = :id')
  Future<Reservation?> getReservationById(String id);

  @Update()
  Future<void> updateReservation(Reservation reservation);

  @insert
  Future<void> insertReservation(Reservation reservation);

  @delete
  Future<void> deleteReservation(Reservation reservation);
}