import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _addTask(String name, String description) async {
    await _tasksCollection.add({
      'name': name,
      'description': description,
      'completed': false,
      'userId': user?.uid,
    });
  }

  Future<void> _updateTask(String id, bool completed) {
    return _tasksCollection.doc(id).update({'completed': completed});
  }

  Future<void> _deleteTask(String id) {
    return _tasksCollection.doc(id).delete();
  }

  void _showTaskDialog({String? id, String? name, String? description, bool? completed}) {
    _taskNameController.text = name ?? '';
    _taskDescriptionController.text = description ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Add Task' : 'Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskNameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: _taskDescriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (id == null) {
                  _addTask(_taskNameController.text, _taskDescriptionController.text);
                } else {
                  _updateTask(id, completed!);
                }
                _taskNameController.clear();
                _taskDescriptionController.clear();
                Navigator.of(context).pop();
              },
              child: Text(id == null ? 'Add' : 'Update'),
            ),
            TextButton(
              onPressed: () {
                _taskNameController.clear();
                _taskDescriptionController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              setState(() {
                user = null;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tasksCollection.where('userId', isEqualTo: user?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task['name']),
                subtitle: Text(task['description']),
                leading: Checkbox(
                  value: task['completed'],
                  onChanged: (value) {
                    _updateTask(task.id, value!);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteTask(task.id);
                  },
                ),
                onTap: () {
                  _showTaskDialog(
                    id: task.id,
                    name: task['name'],
                    description: task['description'],
                    completed: task['completed'],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskDialog();
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
