import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('coffee')
        .where('name', isEqualTo: searchField.toUpperCase())
        .getDocuments();
  }
}
