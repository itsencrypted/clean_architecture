import 'package:cleanarchitecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{
  ///Gers the cached [NumberTriviaModel] which was gotte the last time the
  ///user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cachedNumberTrivia(NumberTriviaModel triviaToCache);
}