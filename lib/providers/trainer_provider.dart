import 'package:flutter/material.dart';
import 'package:your_app/models/trainer_profile.dart';

class TrainerProvider with ChangeNotifier {
  List<TrainerProfile> _clients = [];

  List<TrainerProfile> get clients => _clients;

  void setClients(List<TrainerProfile> clients) {
    _clients = clients;
    notifyListeners();
  }

  void addClient(TrainerProfile client) {
    _clients.add(client);
    notifyListeners();
  }

  void updateClient(TrainerProfile client) {
    final index = _clients.indexWhere((c) => c.id == client.id);
    if (index != -1) {
      _clients[index] = client;
      notifyListeners();
    }
  }

  void removeClient(int id) {
    _clients.removeWhere((client) => client.id == id);
    notifyListeners();
  }
}
