import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cleanarchitecture/core/error/exceptions.dart';
import 'package:cleanarchitecture/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:cleanarchitecture/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}


void main (){
  NumberTriviaRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  
  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(){
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404(){
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went '
        'wrong', 404));
  }
  
  group('getConcreteNumberTrivia', (){
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should perform a GET request on a URL with number being the '
        'endpoint and with application/json header ', () async {
      setUpMockHttpClientSuccess200();
      dataSource.getConcreteNumberTrivia(tNumber);
      verify(mockHttpClient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-type': 'applications/json'} ));
    });

    test('should perform a GET request on a URL with number being the '
        'endpoint and with application/json header ', () async {

      setUpMockHttpClientSuccess200();
      dataSource.getConcreteNumberTrivia(tNumber);
      verify(mockHttpClient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-type': 'applications/json'} ));
    });

    test('should throw a ServerException when the response is a 404 or other ',
            () async {
          setUpMockHttpClientFailure404();
          final call = dataSource.getConcreteNumberTrivia;
          expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
        });


  });


  group('getRandomNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should perform a GET request on a URL with number being the '
        'endpoint and with application/json header ', () async {
      setUpMockHttpClientSuccess200();
      dataSource.getRandomNumberTrivia();
      verify(mockHttpClient.get('http://numbersapi.com/random',
          headers: {'Content-type': 'applications/json'} ));
    });

    test('should perform a GET request on a URL with number being the '
        'endpoint and with application/json header ', () async {

      setUpMockHttpClientSuccess200();
      dataSource.getRandomNumberTrivia();
      verify(mockHttpClient.get('http://numbersapi.com/random',
          headers: {'Content-type': 'applications/json'} ));
    });

    test('should throw a ServerException when the response is a 404 or other ',
            () async {
          setUpMockHttpClientFailure404();
          final call = dataSource.getRandomNumberTrivia;
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        });


  });
}