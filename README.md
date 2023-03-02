# lab4_193059
Laboratoriska vezba 4 po Mobilni informaciski sistemi

- Да се имплементира календар кој ќе овозможи преглед на распоредот за студентот. - Во Flutter_lab4/lib/screens/calendar_screen.dart со помош на зависноста syncfusion_flutter_calendar е имплементиран календар со датумите за секое полагање.
- Да овозможи повеќе корисници со памтење на состојбата за секој корисник со едноставна автентификација. - Flutter_lab4/lib/screens/signin_screen.dart е овозможена состојба за корисникот и автентикација со зависностите firebase_core и firebase_auth
- Да овозможи нотификации (локални или push) за потсетување за некој настан. - главната логика за известувањата е во Flutter_lab4/lib/services/notifications.dart а повикувањето е во Flutter_lab4/lib/screens/home_screen.dart, користени се зависностите intl и flutter_local_notifications
