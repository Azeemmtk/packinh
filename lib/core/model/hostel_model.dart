import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/utils/enums.dart';
import 'package:packinh/core/entity/hostel_entity.dart';

class HostelModel {
  final String id;
  final String name;
  final String placeName;
  final double latitude;
  final double longitude;
  final String contactNumber;
  final String description;
  final List<String> facilities;
  final List<String>? occupantsId;
  final List<Map<String, dynamic>> rooms;
  final String ownerId;
  final String ownerName;
  final String? mainImageUrl;
  final String? mainImagePublicId;
  final List<String> smallImageUrls;
  final List<String> smallImagePublicIds;
  final DateTime createdAt;
  final Status status;
  final double? rating;

  HostelModel({
    required this.id,
    required this.name,
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.contactNumber,
    required this.description,
    required this.facilities,
    this.occupantsId,
    required this.rooms,
    required this.ownerId,
    required this.ownerName,
    this.mainImageUrl,
    this.mainImagePublicId,
    required this.smallImageUrls,
    required this.smallImagePublicIds,
    required this.createdAt,
    required this.status,
    this.rating,
  });

  factory HostelModel.fromEntity(HostelEntity entity) {
    return HostelModel(
      id: entity.id,
      name: entity.name,
      placeName: entity.placeName,
      latitude: entity.latitude,
      longitude: entity.longitude,
      contactNumber: entity.contactNumber,
      description: entity.description,
      facilities: entity.facilities,
      occupantsId: entity.occupantsId,
      rooms: entity.rooms,
      ownerId: entity.ownerId,
      ownerName: entity.ownerName,
      mainImageUrl: entity.mainImageUrl,
      mainImagePublicId: entity.mainImagePublicId,
      smallImageUrls: entity.smallImageUrls,
      smallImagePublicIds: entity.smallImagePublicIds,
      createdAt: entity.createdAt,
      status: entity.status,
      rating: entity.rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'placeName': placeName,
      'latitude': latitude,
      'longitude': longitude,
      'contactNumber': contactNumber,
      'description': description,
      'facilities': facilities,
      'occupantsId': occupantsId,
      'rooms': rooms,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'mainImageUrl': mainImageUrl,
      'mainImagePublicId': mainImagePublicId,
      'smallImageUrls': smallImageUrls,
      'smallImagePublicIds': smallImagePublicIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.value,
      'rating': rating,
    };
  }

  HostelEntity toEntity() {
    return HostelEntity(
      id: id,
      name: name,
      placeName: placeName,
      latitude: latitude,
      longitude: longitude,
      contactNumber: contactNumber,
      description: description,
      facilities: facilities,
      occupantsId: occupantsId,
      rooms: rooms,
      ownerId: ownerId,
      ownerName: ownerName,
      mainImageUrl: mainImageUrl,
      mainImagePublicId: mainImagePublicId,
      smallImageUrls: smallImageUrls,
      smallImagePublicIds: smallImagePublicIds,
      createdAt: createdAt,
      status: status,
      rating: rating,
    );
  }

  factory HostelModel.fromJson(Map<String, dynamic> json) {
    return HostelModel(
      id: json['id'],
      name: json['name'],
      placeName: json['placeName'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      contactNumber: json['contactNumber'],
      description: json['description'],
      facilities: List<String>.from(json['facilities']),
      occupantsId: List<String>.from(json['occupantsId']),
      rooms: List<Map<String, dynamic>>.from(json['rooms']),
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      mainImageUrl: json['mainImageUrl'],
      mainImagePublicId: json['mainImagePublicId'],
      smallImageUrls: List<String>.from(json['smallImageUrls']),
      smallImagePublicIds: List<String>.from(json['smallImagePublicIds']),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      status: StatusExtension.fromString(json['status'] ?? 'pending'),
    );
  }
}
