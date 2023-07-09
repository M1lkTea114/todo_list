import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];

  void addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodoTitle = '';

        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            onChanged: (value) {
              newTodoTitle = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todos.add(Todo(
                    title: newTodoTitle,
                    completed: false,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void toggleTodoCompleted(int index) {
    setState(() {
      todos[index].completed = !todos[index].completed;
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Checkbox(
              value: todos[index].completed,
              onChanged: (value) {
                toggleTodoCompleted(index);
              },
            ),
            title: Text(todos[index].title),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteTodo(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo {
  String title;
  bool completed;

  Todo({
    required this.title,
    required this.completed,
  });
}
