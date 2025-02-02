import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrainingScreen extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      name: 'Push Up',
      sets: 3,
      reps: 15,
      videoUrl: 'https://example.com/pushup.mp4',
    ),
    Exercise(
      name: 'Squat',
      sets: 4,
      reps: 12,
      videoUrl: 'https://example.com/squat.mp4',
    ),
    // Add more exercises here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            child: ListTile(
              title: Text(exercise.name),
              subtitle: Text('Sets: ${exercise.sets}, Reps: ${exercise.reps}'),
              trailing: IconButton(
                icon: Icon(Icons.play_circle_fill),
                onPressed: () {
                  // Add logic to play video
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String videoUrl;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.videoUrl,
  });
}
