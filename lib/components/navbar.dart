import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ac_mobile_final/main.dart';

class MainNav extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool returnButton;

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
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
