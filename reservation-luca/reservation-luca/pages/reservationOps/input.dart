/// CST2335 Final Project.
///
/// Created: July 25, 2025
/// Group Members:
///  - Lingfeng "Galahad" Zhao (zhao0291@algonquinlive.com)
///  - Jesse Proulx (prou0212@algonquinlive.com)
///  - Xinghan Xu (xu000334@algonquinlive.com)
///  - Luca Barbesin (barb0285@algonquinlive.com)
library;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ac_mobile_final/schemas/flight.dart';
import 'package:ac_mobile_final/schemas/customer.dart';

/// A widget that displays input fields for creating or editing a reservation.
///
/// Includes inputs for a note, reservation date, customer dropdown,
/// and flight dropdown. Also contains "Add" and "Clear" buttons.
class InputsBar extends StatelessWidget {
  /// Called when the "Add" button is pressed.
  final VoidCallback onClick;

  /// Called when the "Clear" button is pressed.
  final VoidCallback onReset;

  /// List of all available flights for the dropdown.
  final List<Flight> flights;

  /// List of all available customers for the dropdown.
  final List<Customer> customers;

  /// Controller for the reservation note field.
  final TextEditingController noteController;

  /// Controller for the reservation date field.
  final TextEditingController dateController;

  /// The currently selected customer.
  final Customer? selectedCustomer;

  /// The currently selected flight.
  final Flight? selectedFlight;

  /// Callback when the customer dropdown selection changes.
  final ValueChanged<Customer?> onCustomerChanged;

  /// Callback when the flight dropdown selection changes.
  final ValueChanged<Flight?> onFlightChanged;

  /// Creates an [InputsBar] widget for reservation input.
  ///
  /// All controllers, selection values, and callbacks are required.
  const InputsBar({
    super.key,
    this.selectedFlight,
    this.selectedCustomer,
    required this.onCustomerChanged,
    required this.onFlightChanged,
    required this.flights,
    required this.customers,
    required this.noteController,
    required this.dateController,
    required this.onClick,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final noteInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: noteController,
        decoration: InputDecoration(
          labelText: localizations.label2note,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    final dateInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: dateController,
        readOnly: true, // For picker use
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            dateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          }
        },
        decoration: InputDecoration(
          labelText: localizations.label2flightDate,
          hintText: 'YYYY-MM-DD',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );

    final customerDropdown = Container(
      margin: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<Customer>(
        value: selectedCustomer,
        items: customers.map((customer) {
          return DropdownMenuItem<Customer>(
            value: customer,
            child: Text('${customer.firstname} ${customer.lastname}'),
          );
        }).toList(),
        onChanged: onCustomerChanged,
        decoration: InputDecoration(
          labelText: localizations.label2customerId, // e.g., "Select Customer"
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    final buttonsRow = Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onClick,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.teal.shade50,
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              ),
              child: Text(
                localizations.btn2add,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: onReset,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              ),
              child: Text(
                localizations.btn2clear,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final flightDropdown = Container(
      margin: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<Flight>(
        value: selectedFlight,
        items: flights.map((flight) {
          return DropdownMenuItem<Flight>(
            value: flight,
            child: Text(flight.flightCode), // or any meaningful field
          );
        }).toList(),
        onChanged: onFlightChanged,
        decoration: InputDecoration(
          labelText: localizations.label2flightCode, // e.g., "Select Flight"
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 10.0
      ).copyWith(bottom: 16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              )
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          noteInput,
          dateInput,
          customerDropdown,
          flightDropdown,
          buttonsRow,
        ],
      ),
    );
  }
}
