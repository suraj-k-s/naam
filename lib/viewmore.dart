import 'package:flutter/material.dart';

class AlumniDetailsPage extends StatelessWidget {
  final List<String> alumniDetails;

  const AlumniDetailsPage({required this.alumniDetails});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Name: ${alumniDetails[1]}'),
            Text('House: ${alumniDetails[2]}'),
            Text('Place: ${alumniDetails[3]}'),
            Text('City: ${alumniDetails[4]}'),
            Text('Batch: ${alumniDetails[5]}'),
            Text('Contact: ${alumniDetails[6]}'),
            Text('Profession: ${alumniDetails[7]}'),
            Text('DOB: ${alumniDetails[8]}'),
          ],
        ),
      ),
    );
  }
}
