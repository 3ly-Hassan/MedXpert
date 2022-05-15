import 'package:flutter/cupertino.dart';

class SpecCheckBox {
  String title;
  bool value;

  SpecCheckBox(this.title, {this.value = false});
}

final checkBoxList = [
  SpecCheckBox('Specialist cardiologist'),
  SpecCheckBox(' clinical geneticist'),
  SpecCheckBox('clinical pharmacologist'),
  SpecCheckBox('endocrinologist'),
  SpecCheckBox('Specialist gastroenterologist and hepatologist'),
  SpecCheckBox('Specialist general physician'),
  SpecCheckBox('Specialist geriatrician'),
  SpecCheckBox('Specialist haematologist'),
  SpecCheckBox('Specialist immunologist and allergist'),
  SpecCheckBox('Specialist infectious diseases physician'),
  SpecCheckBox('Specialist medical oncologist'),
  SpecCheckBox('Specialist nephrologist'),
  SpecCheckBox('Specialist neurologist'),
  SpecCheckBox('Specialist nuclear medicine physician'),
  SpecCheckBox('Specialist respiratory and sleep medicine physician'),
  SpecCheckBox('Specialist rheumatologist'),
];
