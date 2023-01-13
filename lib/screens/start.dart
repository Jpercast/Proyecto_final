//Se define una clase que extiende de StatefulWidget y su estado se maneja con _BookSearchPageState
import 'package:dio/dio.dart';
import 'package:flutter/Material.dart';
import 'dart:convert';

late List<Map<String, dynamic>> searchResults;

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

//Se define el estado que maneja la clase BookSearchPage como una clase aninada y se declaran dos variables query y searchResults
class _BookSearchPageState extends State<BookSearchPage> {
  String? query;
  //late List<Map<String, dynamic>> searchResults;

//Se define un método getBooks que hace la petición HTTP utilizando Dio, se utiliza Future para poder -
//esperar a la respuesta antes de continuar la ejecución.
  Future<List<Map<String, dynamic>>> getBooks(String query) async {
    Dio dio = Dio();
    String url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=AIzaSyBy5gJHq5VoHENbyhZP4ZiET_ROkdp0OiM';

//En este bloque se hace la petición HTTP utilizando el método get de Dio, especificando la URL de la API de Google Books.
//En caso de éxito, el resultado es parseado y se devuelve una lista de Map<String, dynamic> que representa los items encontrados.
//En caso de error se imprime en consola.
    try {
      final response = await dio.get(url);
      return (response.data['items'] as List)
          .map((i) => i as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e);
    }
    return null!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca tu Libro'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          MaterialButton(
              child: Text('Search'),
              onPressed: () {
                setState(() {});
              }),
          Expanded(
            //`FutureBuilder` para mostrar los resultados obtenidos de la petición HTTP.
            //El `FutureBuilder` tiene un `future` que es el resultado del método `getBooks` y un `builder` -
            //que se encarga de mostrar los resultados en una `ListView`.
            child: FutureBuilder(
              future: getBooks('$query'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  searchResults = snapshot.data;
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            Text(searchResults[index]['volumeInfo']['title']),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/book',
                            arguments: searchResults[index]['volumeInfo'],
                          );
                        },
                        subtitle: Text(
                            searchResults[index]['volumeInfo']['authors'][0]),
                        trailing: Container(
                          width: 60.0,
                          height: 60.0,
                          child: Image.network(
                            searchResults[index]['volumeInfo']['imageLinks'] !=
                                        null &&
                                    searchResults[index]['volumeInfo']
                                            ['imageLinks']['thumbnail'] !=
                                        null
                                ? searchResults[index]['volumeInfo']
                                    ['imageLinks']['thumbnail']
                                : 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                          ),
                        ),
                        leading: Text(searchResults[index]['volumeInfo']
                                ['publishedDate']
                            .substring(0, 4)),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Nada que Mostrar "Que Aburrido..."',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Clase para detalles de libros

class BookDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> book =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(book['imageLinks'] != null ||
                                book['imageLinks']['thumbnail'] != null
                            ? book['imageLinks']['thumbnail']
                            : 'https://via.placeholder.com/150'),
                        fit: BoxFit.cover))),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            Text(book['description'] ?? 'No hay descripción disponible',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Text(
                book['publishedDate'] ??
                    'No hay fecha de publicación disponible',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
