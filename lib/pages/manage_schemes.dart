import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ManageSchemesPage(),
    theme: ThemeData.dark(),
  ));
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
    // TODO: Implement backend integration to save scheme data
    // For now, the code just prints the scheme details
    print('Scheme ID: $schemeId');
    print('Scheme Name: $schemeName');
    print('Scheme Description: $schemeDescription');

    final snackBar = SnackBar(content: Text('Scheme added successfully'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    toggleAddingScheme();
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
                  maxLines: 5, // Specify the number of lines for the description
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
                  // TODO: Implement navigation to view/manage existing schemes page
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
}
