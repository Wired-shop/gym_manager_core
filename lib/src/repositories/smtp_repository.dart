import 'package:gym_manager_core/core.dart';

class SmtpRepository {
  //TODO: Compleatare invio
  static final String _html =
      r'''<!DOCTYPE html>\n<html lang=\"it\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>Norme di Comportamento</title>\n    <style>\n        body {\n            font-family: Arial, sans-serif;\n            line-height: 1.6;\n            margin: 20px;\n            padding: 0;\n            background-color: #f4f4f4;\n        }\n        .container {\n            max-width: 800px;\n            margin: 0 auto;\n            padding: 20px;\n            background: #fff;\n            border-radius: 8px;\n            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\n        }\n        h1 {\n            color: #333;\n        }\n        ol {\n            margin: 20px 0;\n        }\n        li {\n            margin-bottom: 10px;\n        }\n        footer {\n            margin-top: 20px;\n            font-size: 0.9em;\n            color: #555;\n        }\n    </style>\n</head>\n<body>\n    <div class=\"container\">\n        <h1>Gentile Socio,</h1>\n        <p>Ti ringraziamo per la fiducia che ci hai accordato. Siamo impegnati a offrirti il miglior servizio possibile e desideriamo fornirti alcune informazioni importanti per garantire un ambiente sereno e rispettoso per tutti.</p>\n        <ol>\n            <li>Porta con te asciugamano, acqua e, se necessario, una maglia di ricambio per eccessivo sudore. Gli spazi sono condivisi, e questo è un segno di rispetto verso gli altri. Utilizza alcool e carta per pulire gli attrezzi se necessario.</li>\n            <li>Assicurati di scaricare il pacco pesi dopo l'uso.</li>\n            <li>Non sbattere gli attrezzi; questo non solo crea rumore, ma accelera anche il loro deterioramento.</li>\n            <li>Mantieni sempre la maglietta indossata, specialmente in spazi condivisi.</li>\n            <li>Evita di utilizzare un linguaggio inappropriato.</li>\n            <li>La palestra chiude alle ore 22:00, ma l'ultimo accesso in sala è possibile fino alle 21:10.</li>\n            <li>Segnala qualsiasi disagio alla segreteria. Accogliamo con piacere suggerimenti costruttivi per migliorare il servizio.</li>\n        </ol>\n        <p>Desideriamo continuare a offrirti il servizio docce senza costi aggiuntivi. Per questo motivo, ti chiediamo di dimostrare senso civico e responsabilità. Sarai richiamato se il comportamento non sarà conforme a queste norme.</p>\n        <p>Ti auguriamo un buon allenamento e siamo certi che lavoreremo insieme per un'esperienza positiva.</p>\n        <footer>\n            Cordiali saluti,<br>\n            Il Team\n        </footer>\n    </div>\n</body>\n</html>''';
  static final String _subject = "Benvenuto!";

  static Future sendEmail(
      {required String destination,
      required String subject,
      required String html}) async {
    //TODO: Eliminare questi parametri
    html = _html;
    subject = _subject;
    String url =
        "${ApiService.getIstance().getIp()}:${ApiService.getIstance().getPort()}/send_email";
    var response = await ApiService.getIstance().dio.post(url, data: {
      "html": html,
      "subject": subject,
      "destination": destination,
    });
    if (response.data["responseType"] == "error") {
      throw response.data;
    }
  }
}
