import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:ac_mobile_final/schemas/customer.dart';
import 'package:ac_mobile_final/schemas/airplane.dart';
import 'package:ac_mobile_final/schemas/flight.dart';
import 'package:ac_mobile_final/schemas/reservation.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Customer, Airplane, Flight, Reservation])
abstract class FinalDB extends FloorDatabase {
  CustomerDAO get customerDAO;
  AirplaneDAO get airplaneDAO;
  FlightDAO get flightDAO;
  ReservationDAO get reservationDAO;
}
