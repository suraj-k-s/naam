import 'package:flutter/material.dart';
import 'package:naam/sheet_api.dart';

class ListAlumni extends StatefulWidget {
  final String? selectedValue;

  const ListAlumni({Key? key, this.selectedValue}) : super(key: key);

  @override
  State<ListAlumni> createState() => _ListAlumniState();
}

class _ListAlumniState extends State<ListAlumni> {
  List<List<String>> alumniData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<List<String>> data = await SheetApi.fetchAlumniData();
      setState(() {
        alumniData = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String getValueOrNA(String? value) {
    return value ?? 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Alumni'),
        actions: [
          Container(
            height: AppBar().preferredSize.height,
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/Logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: Center(
        child: alumniData.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: alumniData.length - 1,
                itemBuilder: (context, index) {
                  List<String> rowData = alumniData[index + 1];
                  return ListTile(
                    title: Text(
                      getValueOrNA(rowData[1]),
                      style: TextStyle(
                          fontWeight: FontWeight.bold), 
                    ),
                    subtitle: Text(getValueOrNA(rowData[5])), 
                    trailing: Text(getValueOrNA(rowData[3])), 
                  );
                },
              ),
      ),
    );
  }
}
