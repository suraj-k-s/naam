import 'package:gsheets/gsheets.dart';
import 'package:naam/alumni.dart';

class SheetApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "naam-1999",
  "private_key_id": "b7aa324799197a0e592e918c6285a954603587ef",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQChTVRH7IjtVpsv\n8TOqLcJWzRw2Q2s9ngV8WkjIPxHWJWPwmf/VToxawQQ14TrFsoY2qYoQHJHY1V1G\n2PVoLO8ZWx8B8s+rDasI+871xB2DDjb9zUlHnoYVaxzXTUmw8mhioNfKQaB0Y1N0\nFYoA5WemvT4IWUUnCb7LlMItEPYEoG7hwR+XKICZ8Qe85xzlmgCieNqep68HXShp\nYmU71MFW1jSi4UAVHPFkqwYN+knqEwfqCCP0nxwRo/R8Y7x9k8dtwuugqc9GtaB6\n6qJjpk1DGmUKPIsmNG7nbsZDMOD1rAfvEYZ4oMwQunUKA3/KjuwSEfQiVBl0dKhH\nlNGmMdIPAgMBAAECggEANeOG38yXZmuDxz2XHCjTf3phDYPypRBRFt126WegxuGR\nBQX+Ib5vR7aqeHG51+ivzD1SAdX5p+6Iji3Xtykj7F2z+0uqs6QKWyL9XsBZd7pd\nBuf5rnK4qxkw9oE8uGAUHbdMwKayO5Afhm3XwDrkKSGaQuHIJ6Wq14roYHQFLUAA\nCUheZI+ldaqzzT9HNKMMcIIwSmoTOU3gH6CBHqEl38TsVC/20/WyczsT64OWkVi+\nk1W6KRK/AP5TUpiG79RRaRfZwGwtynRoqPjVw+sRl4x5YQO0VUNMMJ6zIjKYnU/b\nQjEEzv+Pctvej4FpO8aJ/XAfbkw1TWRcg/aI934RSQKBgQDaabKF3Wdh/33Hq1fs\nkqnOhCiMARRaZ2SpIReWCb7grSnr+61HBUhrexe7u+fpqvop6+Vts23WjuxoB+cS\n8JYPSxlpKraQzZdCkwzJpvONarzOEmguzIA3uKRYsoJqdFDe/v9+U46d2ArEB/AM\neDlkEO5KlSxeRiN3MDtGPBBKDQKBgQC9D5UxXLUogL+5JzxVMLxXEiKC31nzG5c/\nmdl07jiS9SX2iapJJ3E0fS7LXDD2MwP2ZLIcTmTeP5mf7GRTHjpsFbFGaBWF4afs\nf7r40sNnntzcHB7831+GHhh54NKhBOMxDTQ+O4n/JNRLchBa5/wcwKHefRUrL1Oc\n9ZgKQDnRiwKBgQChBxiFtWyJRdK4KU2Tr7Xd+nXictFMrbn7L9ix19GQ2Fp2D4H7\nQJvaElC3KpybHGGAEtl9/bHXZFxLfrgQsKwR7m53qPQc4lbI0J229o3OD4nP7KY/\nCqrlag5RDps0XTlaj2pS+svE+AlH6gpDR0gYzJrDBiRGBTQUpcytxY7E6QKBgQCH\nLP8VHh4A6Z0rOxxuJLxk3PiD7kIYCiAoP041xqX4nQMZtPBmAad1ShQNHst7HJq2\nruSSTJLePUcQCyroKvLGmPP5TS4mXWN9Ow5qHffMvM9ZKVoWn3djI12ItvCiZCY0\nyiYSYOuX27NWhiWfecLOpASYWYKrL9lunkKpAabVZQKBgQCYl1CmdMwrMvcHc1Q1\nnzABQsrO9XaxMa+v9Cyqk/HP+9U7Y+VVBS38kMQ5SiMOpWKSAhhmk4dnfIEdZalH\nj/Q4XZKCfd99PeLg+6dkbZiQDCT4FCR8v4DSlTt/zqbxnfHilYVW6UMruAZYdDkK\nenCZ5ObutBpQy2rk1e3UEIadTA==\n-----END PRIVATE KEY-----\n",
  "client_email": "alumni@naam-1999.iam.gserviceaccount.com",
  "client_id": "117092250971323800218",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/alumni%40naam-1999.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

 ''';
  static final _sheetId = "1gg2vk8_xAlHjhJn0frJ4mEt_OP3Ia8qz314uU3SJm6g";

  static final _gsheets = GSheets(_credentials);

  static Worksheet? _alumniSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);
      _alumniSheet = await _getWorkSheet(spreadsheet, title: "Alumni");
      final firstRow = AlumniFields.getFields();
      _alumniSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future<List<List<String>>> fetchAlumniData() async {
    final spreadsheet = await _gsheets.spreadsheet(_sheetId);
    final alumniSheet = await spreadsheet.worksheetByTitle("Alumni");
    final allRows = await alumniSheet!.values.allRows();
    return allRows;
  }

  static Future<List<String>> fetchBatchData() async {
    final spreadsheet = await _gsheets.spreadsheet(_sheetId);
    final batchSheet = await spreadsheet.worksheetByTitle("Alumni");

    if (batchSheet == null) {
      print("Sheet is Null");
      return [];
    }

    final allRows = await batchSheet.values.allRows();

    Set<String> uniqueBatches = Set();
    List<String> batchData = [];

    for (var rowData in allRows.skip(1)) {
      String batch = rowData[4];
      if (!uniqueBatches.contains(batch)) {
        batchData.add(batch);
        uniqueBatches.add(batch);
      }
    }

    return batchData;
  }
}
