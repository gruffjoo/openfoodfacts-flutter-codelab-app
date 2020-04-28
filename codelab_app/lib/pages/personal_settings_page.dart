import 'package:codelab_app/providers/personal_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalSettingsPage extends StatefulWidget {
  @override
  _PersonalSettingsPageState createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  //
  // ########### UI
  //

  Widget _buildAgeSlider() {
    double age = Provider.of<PersonalSettingsProvider>(context).age;
    return Column(
      children: <Widget>[
        Text("Age : ${age.toInt()} ans"),
        Slider(
          label: "${age.toInt()}",
          value: age,
          onChanged:
              Provider.of<PersonalSettingsProvider>(context, listen: false)
                  .setAge,
          min: 0,
          max: 100,
          divisions: 100,
        ),
      ],
    );
  }

  Widget _buildWeightSlider() {
    double weight = Provider.of<PersonalSettingsProvider>(context).weight;
    return Column(
      children: <Widget>[
        Text("Poids : ${weight.toInt()} kg"),
        Slider(
          label: "${weight.toInt()}",
          value: weight,
          onChanged:
              Provider.of<PersonalSettingsProvider>(context, listen: false)
                  .setWeight,
          min: 0,
          max: 200,
          divisions: 200,
        ),
      ],
    );
  }

  Widget _buildPageContent() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          _buildAgeSlider(),
          SizedBox(
            height: 30,
          ),
          _buildWeightSlider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: _buildPageContent(),
    );
  }
}
