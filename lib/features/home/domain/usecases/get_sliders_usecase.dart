import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/home/domain/entities/slider_entity.dart';
import 'package:bookia_store/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetSlidersUsecase {
  final HomeRepository repository;
  GetSlidersUsecase(this.repository);

  Future<Either<Failure,List<SliderEntity>>> call() async {
    return await repository.getSliders();
  }
}