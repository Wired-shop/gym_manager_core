import 'package:gym_manager_core/core.dart';

class SmtpRepository {
  //TODO: Compleatare invio
  static final String _html = '''
  <!DOCTYPE html>
  <html lang="it">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Norme di Comportamento</title>
      <style>
          body {
              font-family: Arial, sans-serif;
              line-height: 1.6;
              margin: 20px;
              padding: 0;
              background-color: #f4f4f4;
          }
          .container {
              max-width: 800px;
              margin: 0 auto;
              padding: 20px;
              background: #fff;
              border-radius: 8px;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          }
          h1 {
              color: #333;
          }
          ol {
              margin: 20px 0;
          }
          li {
              margin-bottom: 10px;
          }
          footer {
              margin-top: 20px;
              font-size: 0.9em;
              color: #555;
          }
      </style>
  </head>
  <body>
      <div class="container">
          <h1>Gentile Socio</h1>
          <p>Grati per la fiducia che ci hai accordato, sicuri di operare al meglio per garantirti un buon lavoro, ti accogliamo informandoti anticipatamente delle norme che devono essere condivise per garantire ambienti sereni.</p>
          
          <ol>
              <li>Porta con te asciugamano, acqua e, se necessario, cambiati la maglia per eccessivo sudore. I luoghi sono condivisi quindi questo rappresenta indice di rispetto. Se necessario, usufruirai di alcool e carta per pulire gli attrezzi.</li>
              <li>Garantisci lo scarico del pacco pesi.</li>
              <li>Non sbattere gli attrezzi perché oltre a produrre rumore faciliterai la loro usura.</li>
              <li>Stai in sala sempre con la maglietta, specie se gli ambienti sono condivisi.</li>
              <li>Evita di utilizzare un linguaggio poco educato.</li>
              <li>La palestra chiuderà alle ore 22:00; ma l’ultimo accesso in sala sarà garantito sino alle 21:10.</li>
              <li>Avvisaci per qualsiasi disagio rivolgendoti alla segreteria. Cercheremo di accogliere le tue proposte se propositive al miglioramento.</li>
          </ol>
          
          <p>Vogliamo continuare ad offrirti il servizio docce senza supplemento, quindi ti chiediamo senso civico e responsabilità. Verrai richiamato se fosse il contrario.</p>
          
          <footer>
              Sicuri di un lavoro collaborativo, vi auguriamo Buon allenamento.
          </footer>
      </div>
  </body>
  </html>''';
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
