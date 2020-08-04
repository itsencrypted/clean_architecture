import 'package:cleanarchitecture/core/use_cases/use_case.dart';
import 'package:cleanarchitecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:cleanarchitecture/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{}

void main(){
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(text: 'whatever text', number: 1);

  test(
      'should get trivia from the repository',
          ()async {
        //arrange
        when(mockNumberTriviaRepository.getRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
        //act
        final result = await usecase(NoParams());
        // assert
        expect(result, Right(tNumberTrivia));
        verify(mockNumberTriviaRepository.getRandomNumberTrivia());
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      }
  );
}