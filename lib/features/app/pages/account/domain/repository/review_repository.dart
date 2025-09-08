import '../../../my_hostel/data/model/review_model.dart';

abstract class ReviewRepository {
  Stream<List<ReviewModel>> getReviews(String hostelId);
}
