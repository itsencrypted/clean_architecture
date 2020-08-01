import 'package:cleanarchitecture/core/error/failures.dart';
import 'package:cleanarchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  //this type of return returns Either a Failure on the Left side (L), or the
  // success data, in this case NumberTrivia on the Right side(R)
  //This way we are not going to need to catch exceptions anywhere else in
  // the App then the repository.
  Future<Either<Failure, NumberTrivia>>getConcreteNumberTrivia(int number);

  Future<Either<Failure, NumberTrivia>>getRandomNumberTrivia();
}