import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ac_mobile_final/main.dart';

/// A customizable app bar widget with optional back navigation and language selector.
///
/// Displays a centered title and a language menu (English/French).
/// The back button is shown if [returnButton] is true.
class MainNav extends StatelessWidget implements PreferredSizeWidget {
  /// The title text displayed in the center of the app bar.
  final String title;

  /// Whether to show the back button on the leading side.
  final bool returnButton;

  /// Creates a [MainNav] widget.
  ///
  /// Both [title] and [returnButton] are required.
  const MainNav({
    super.key,
    required this.title,
    required this.returnButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      leading: returnButton ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ) : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        PopupMenuButton<Locale>(
          icon: Icon(
            Icons.language,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          tooltip: 'Select Language',
          onSelected: (Locale selectedLocale) {
            MyApp.of(context)?.setLocale(selectedLocale);
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: const Locale('en'),
              child: Row(
                children: [
                  const Text("🇬🇧 "),
                  const SizedBox(width: 8),
                  Text(
                    'English',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: const Locale('fr'),
              child: Row(
                children: [
                  const Text("🇫🇷 "),
                  const SizedBox(width: 8),
                  Text(
                    'French',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: const Locale('zh'),
              child: Row(
                children: [
                  const Text("🇨🇳 "),
                  const SizedBox(width: 8),
                  Text(
                    '中文 (简体)',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: const Locale('ko'),
              child: Row(
                children: [
                  const Text("🇰🇷 "),
                  const SizedBox(width: 8),
                  Text(
                    '한국어',
                    style: GoogleFonts.lato(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
