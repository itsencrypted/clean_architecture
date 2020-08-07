import 'dart:convert';

import 'package:cleanarchitecture/core/error/exceptions.dart';
import 'package:cleanarchitecture/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:cleanarchitecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
        'should return numberTrivia from SharedPreferences when there is one in the cache',
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await dataSource.getLastNumberTrivia();

      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });


    test(
        'should throw CacheException when there is no cached value',
            () async {
          when(mockSharedPreferences.getString(any))
              .thenReturn(null);

          final call = dataSource.getLastNumberTrivia;
          
          expect(() => call(), throwsA(TypeMatcher<CacheException>()));

        });

  });
  
  
  group('cacheNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test '
        'trivia');

    test('should call SharedPreferences to cache the data', () async{
      dataSource.cachedNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode((tNumberTriviaModel.toJson()));

      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));

    });




  });
  
  
}
