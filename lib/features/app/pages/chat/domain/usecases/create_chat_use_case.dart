import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/chat_repository.dart';

class CreateChatUseCase extends UseCase<String, String> {
  final ChatRepository repository;

  CreateChatUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.createChat(params);
  }
}
