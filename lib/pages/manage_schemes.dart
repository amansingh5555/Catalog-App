import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ManageSchemesPage(),
    theme: ThemeData.dark(),
  ));
}

class Scheme {
  final String schemeId;
  final String schemeName;
  final String schemeDescription;

  Scheme(this.schemeId, this.schemeName, this.schemeDescription);
}

class ManageSchemesPage extends StatefulWidget {
  @override
  _ManageSchemesPageState createState() => _ManageSchemesPageState();
}

class _ManageSchemesPageState extends State<ManageSchemesPage> {
  TextEditingController schemeIdController = TextEditingController();
  TextEditingController schemeNameController = TextEditingController();
  TextEditingController schemeDescriptionController = TextEditingController();

  bool isAddingScheme = false;

  List<Scheme> existingSchemes = [];

  void toggleAddingScheme() {
    setState(() {
      isAddingScheme = !isAddingScheme;
      if (!isAddingScheme) {
        schemeIdController.clear();
        schemeNameController.clear();
        schemeDescriptionController.clear();
      }
    });
  }

  void addScheme(String schemeId, String schemeName, String schemeDescription) {
    final newScheme = Scheme(schemeId, schemeName, schemeDescription);
    existingSchemes.add(newScheme);

    final snackBar = SnackBar(content: Text('Scheme added successfully'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    toggleAddingScheme();
  }

  bool _validateInput() {
    if (schemeIdController.text.isEmpty || schemeIdController.text.length != 5) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid Scheme ID'),
            content: Text('Scheme ID should be 5 alphanumeric characters.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Schemes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Icon(
                    Icons.extension,
                    size: 64,
                    color: Colors.blue,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: toggleAddingScheme,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAddingScheme ? Colors.red : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  isAddingScheme ? 'Cancel' : 'Add Scheme',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16.0),
              if (isAddingScheme) ...[
                TextFormField(
                  controller: schemeIdController,
                  decoration: InputDecoration(
                    labelText: 'Scheme ID (5 alphanumeric characters)',
                    prefixIcon: Icon(Icons.vpn_key, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: schemeNameController,
                  decoration: InputDecoration(
                    labelText: 'Scheme Name',
                    prefixIcon: Icon(Icons.label, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: schemeDescriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Scheme Description',
                    prefixIcon: Icon(Icons.description, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_validateInput()) {
                      addScheme(
                        schemeIdController.text,
                        schemeNameController.text,
                        schemeDescriptionController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Add Scheme',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExistingSchemesPage(existingSchemes),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'View/Manage Existing Schemes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExistingSchemesPage extends StatelessWidget {
  final List<Scheme> existingSchemes;

  ExistingSchemesPage(this.existingSchemes);

  void _deleteScheme(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this scheme?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                existingSchemes.removeAt(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Scheme deleted successfully')),
                );
              },
              child: Text('Delete'),
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
        title: Text('Existing Schemes'),
      ),
      body: ListView.builder(
        itemCount: existingSchemes.length,
        itemBuilder: (context, index) {
          final scheme = existingSchemes[index];
          return ListTile(
            title: Text(scheme.schemeName),
            subtitle: Text(scheme.schemeDescription),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteScheme(context, index),
            ),
          );
        },
      ),
    );
  }
}
