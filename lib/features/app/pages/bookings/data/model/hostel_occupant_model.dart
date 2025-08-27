
import '../../../../../../core/model/hostel_model.dart';
import '../../../../../../core/model/occupants_model.dart';

class HostelOccupantsModel {
  final HostelModel hostel;
  final List<OccupantModel> occupants;

  HostelOccupantsModel({
    required this.hostel,
    required this.occupants,
  });

  factory HostelOccupantsModel.fromJson(Map<String, dynamic> json) {
    return HostelOccupantsModel(
      hostel: HostelModel.fromJson(json['hostel']),
      occupants: (json['occupants'] as List).map((e) => OccupantModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hostel': hostel.toJson(),
      'occupants': occupants.map((e) => e.toJson()).toList(),
    };
  }
}