/// CST2335 Final Project.
///
/// Created: July 25, 2025
/// Group Members:
///  - Lingfeng "Galahad" Zhao (zhao0291@algonquinlive.com)
///  - Jesse Proulx (prou0212@algonquinlive.com)
///  - Xinghan Xu (xu000334@algonquinlive.com)
///  - Luca Barbesin (barb0285@algonquinlive.com)
library;

import 'package:ac_mobile_final/schemas/database.dart';
import 'package:ac_mobile_final/schemas/customer.dart';
import 'package:ac_mobile_final/schemas/airplane.dart';
import 'package:ac_mobile_final/schemas/flight.dart';
import 'package:ac_mobile_final/schemas/reservation.dart';

class DataSource {
  static final DataSource _instance = DataSource._internal();

  static late FinalDB _db;
  static late CustomerDAO _customerDAO;
  static late AirplaneDAO _airplaneDAO;
  static late FlightDAO _flightDAO;
  static late ReservationDAO _reservationDAO;

  static List<Customer> customers = [];
  static List<Airplane> airplanes = [];
  static List<Flight> flights = [];
  static List<Reservation> reservations = [];

  DataSource._internal();

  static DataSource get instance => _instance;

  static Future<void> init() async {
    _db = await $FloorFinalDB.databaseBuilder('app_final.db').build();
    _customerDAO = _db.customerDAO;
    _airplaneDAO = _db.airplaneDAO;
    _flightDAO = _db.flightDAO;
    _reservationDAO = _db.reservationDAO;
  }

  Future<void> syncAll() async {
    customers = await _customerDAO.listCustomers();
    airplanes = await _airplaneDAO.listAirplanes();
    flights = await _flightDAO.listFlights();
    reservations = await _reservationDAO.listReservations();
  }

  Future<void> syncCustomers() async {
    customers = await _customerDAO.listCustomers();
  }

  Future<void> syncAirplanes() async {
    airplanes = await _airplaneDAO.listAirplanes();
  }

  Future<void> syncFlights() async {
    flights = await _flightDAO.listFlights();
  }

  Future<void> syncReservations() async {
    reservations = await _reservationDAO.listReservations();
  }

  Future<void> addCustomer(Customer customer) async {
    await _customerDAO.insertCustomer(customer);
    await syncCustomers();
  }

  Future<void> addAirplane(Airplane airplane) async {
    await _airplaneDAO.insertAirplane(airplane);
    await syncAirplanes();
  }

  Future<void> addFlight(Flight flight) async {
    await _flightDAO.insertFlight(flight);
    await syncFlights();
  }

  Future<void> addReservation(Reservation reservation) async {
    await _reservationDAO.insertReservation(reservation);
    await syncReservations();
  }

  Future<void> updateCustomer(Customer customer) async {
    await _customerDAO.updateCustomer(customer);
    await syncCustomers();
  }

  Future<void> updateAirplane(Airplane airplane) async {
    await _airplaneDAO.updateAirplane(airplane);
    await syncAirplanes();
  }

  Future<void> updateFlight(Flight flight) async {
    await _flightDAO.updateFlight(flight);
    await syncFlights();
  }

  Future<void> updateReservation(Reservation reservation) async {
    await _reservationDAO.updateReservation(reservation);
    await syncReservations();
  }

  Future<void> deleteCustomer(Customer customer) async {
    await _customerDAO.deleteCustomer(customer);
    await syncCustomers();
  }

  Future<void> deleteAirplane(Airplane airplane) async {
    await _airplaneDAO.deleteAirplane(airplane);
    await syncAirplanes();
  }

  Future<void> deleteFlight(Flight flight) async {
    await _flightDAO.deleteFlight(flight);
    await syncFlights();
  }

  Future<void> deleteReservation(Reservation reservation) async {
    await _reservationDAO.deleteReservation(reservation);
    await syncReservations();
  }
}