
import 'package:flutter/material.dart';

class MinistryModel {

  String _name, _parent, _id;


  MinistryModel(this._name, this._parent, this._id);

  String get parent => _parent;

  String get name => _name;

  get id => _id;


}