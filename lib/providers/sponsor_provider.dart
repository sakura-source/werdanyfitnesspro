import 'package:flutter/material.dart';
import 'package:your_app/models/sponsor.dart';

class SponsorProvider with ChangeNotifier {
  List<Sponsor> _sponsors = [];

  List<Sponsor> get sponsors => _sponsors;

  void setSponsors(List<Sponsor> sponsors) {
    _sponsors = sponsors;
    notifyListeners();
  }

  void addSponsor(Sponsor sponsor) {
    _sponsors.add(sponsor);
    notifyListeners();
  }

  void removeSponsor(String id) {
    _sponsors.removeWhere((sponsor) => sponsor.id == id);
    notifyListeners();
  }
}
