import 'package:braga8_tenant_app/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Braga8TenantApp());
}

class Braga8TenantApp extends StatelessWidget {
  const Braga8TenantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braga8 Tenant App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF523631),
          brightness: Brightness.dark,
          primary: Color(0xFF523631),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.black54),
        ),
        scaffoldBackgroundColor: Color(0xFF141315),
        splashColor: Color(0xFF786161).withValues(alpha: .1),
        highlightColor: Color(0xFF786161).withValues(alpha: .05),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Color(0xFF523631).withValues(alpha: .4),
          cursorColor: Color(0xFF523631),
          selectionHandleColor: Color(0xFF523631),
        ),

        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
