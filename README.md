# salkin_carlock

Ein einfaches und effizientes Fahrzeug-Schließsystem für FiveM (ESX). Ermöglicht Spielern das Abschließen ihrer eigenen Fahrzeuge mit visuellen und akustischen Effekten.

## 🔑 Features
*   **Besitzerprüfung:** Funktioniert nur bei Fahrzeugen, die in der `owned_vehicles` Tabelle dem Spieler gehören.
*   **Animationen:** Der Charakter spielt eine Schlüssel-Animation ab (sofern er nicht im Auto sitzt).
*   **Visuelle Effekte:** Die Lichter des Fahrzeugs blinken beim Auf- und Abschließen.
*   **Audio Support:** Unterstützt `InteractSound` für ein "Bleep-Geräusch" (optional).
*   **Optimiert:** Minimale Auslastung des Clients.

## 🛠 Installation
1. Kopiere den Ordner `salkin_carlock` in dein `resources` Verzeichnis.
2. Füge `ensure salkin_carlock` in deine `server.cfg` ein.
3. (Optional) Stelle sicher, dass du eine Sounddatei namens `carlock.ogg` in `InteractSound` hast, wenn du Töne nutzen möchtest.

## 📖 Bedienung
*   Stelle dich neben dein Fahrzeug oder sitze darin.
*   Drücke die Taste **[G]** (konfigurierbar), um das Fahrzeug zu sperren oder zu entsperren.
