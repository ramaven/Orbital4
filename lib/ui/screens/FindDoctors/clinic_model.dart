class Clinic {
  int clinicID;
  String name;
  String contact;
  String postal;
  String block;
  String floor;
  String unit;
  String street;
  String building;
  List<double> coordinates;

  Clinic(this.clinicID, this.name, this.contact, this.postal, this.block,
      this.floor, this.unit, this.street, this.building, this.coordinates);

  // Clinic.fromJson(Map<String, dynamic> json) {}
}
