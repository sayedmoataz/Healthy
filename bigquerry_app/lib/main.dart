import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/bigquery/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

void main() {
  runApp(const BigQueryApp());
}

class BigQueryApp extends StatelessWidget {
  const BigQueryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQL Talk with BigQuery',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BigQueryHomePage(),
    );
  }
}

class BigQueryHomePage extends StatefulWidget {
  const BigQueryHomePage({super.key});

  @override
  _BigQueryHomePageState createState() => _BigQueryHomePageState();
}

class _BigQueryHomePageState extends State<BigQueryHomePage> {
  final String _projectId = "matchbuy-c1dbb";
  final String _datasetId = "matchbuy-c1dbb.matchBuy";
  final TextEditingController _promptController = TextEditingController();
  String? _responseText;
  late BigqueryApi bigquery;

  @override
  void initState() {
    super.initState();
    _initBigQuery();
  }

  Future<void> _initBigQuery() async {
    final jsonKey = await rootBundle.loadString('assets/matchbuy.json');
    final accountCredentials =
        ServiceAccountCredentials.fromJson(jsonDecode(jsonKey));
    final client = await clientViaServiceAccount(
        accountCredentials, [BigqueryApi.cloudPlatformScope]);
    setState(() {
      bigquery = BigqueryApi(client);
    });
  }

  /// Function declarations mapped to callable actions.
  final Map<String, Function> _functions = {};

  /// Initialize the function map
  void _initializeFunctions() {
    _functions["list_datasets"] = () async => _listDatasets();
    _functions["list_tables"] =
        (String datasetId) async => _listTables(datasetId);
    _functions["get_table"] = (String tableId) async => _getTable(tableId);
    _functions["sql_query"] = (String query) async => _sqlQuery(query);
  }

  Future<String> _listDatasets() async {
    final datasets = await bigquery.datasets.list(_projectId);
    return datasets.datasets
            ?.map((d) => d.datasetReference?.datasetId)
            .join(", ") ??
        "No datasets found.";
  }

  Future<String> _listTables(String datasetId) async {
    final tables = await bigquery.tables.list(_projectId, datasetId);
    return tables.tables?.map((t) => t.tableReference?.tableId).join(", ") ??
        "No tables found.";
  }

  Future<String> _getTable(String tableId) async {
    final table = await bigquery.tables.get(_projectId, _datasetId, tableId);
    log('table is: $table');
    final schema = table.schema?.fields?.map((f) => f.name).join(", ") ??"No schema found.";
    return "Table: ${table.friendlyName}\nSchema: $schema";
  }

  Future<String> _sqlQuery(String query) async {
    final queryRequest = QueryRequest(query: query);
    final queryResponse = await bigquery.jobs.query(queryRequest, _projectId);

    if (queryResponse.rows != null) {
      return queryResponse.rows!.map((row) {
        return row.f!.map((field) => field.v).join(", ");
      }).join("\n");
    }
    return "No results found.";
  }

  /// Handle user input and dynamically call the appropriate function.
  Future<void> _handlePrompt(String prompt) async {
    setState(() {
      _responseText = "Processing...";
    });

    try {
      final parts = prompt.split(" ");
      final functionName = parts.first; // e.g., "list_tables"
      final args = parts.skip(1).toList(); // Arguments for the function

      if (_functions.containsKey(functionName)) {
        final dynamic result =
            await Function.apply(_functions[functionName]!, args);
        setState(() {
          _responseText = result.toString();
        });
      } else {
        setState(() {
          _responseText = "Unknown function: $functionName";
        });
      }
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeFunctions();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SQL Talk with BigQuery"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    "Enter a function call (e.g., list_tables thelook_ecommerce)...",
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final prompt = _promptController.text.trim();
                _handlePrompt(prompt);
              },
              child: const Text("Run"),
            ),
            const SizedBox(height: 20),
            if (_responseText != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _responseText!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
