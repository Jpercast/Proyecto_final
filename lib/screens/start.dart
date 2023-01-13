//Se define una clase que extiende de StatefulWidget y su estado se maneja con _BookSearchPageState
import 'package:dio/dio.dart';
import 'package:flutter/Material.dart';
import 'dart:convert';

late List<Map<String, dynamic>> searchResults;

//Se define una clase que extiende de StatefulWidget y su estado se maneja con _BookSearchPageState
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
    try {
      final response = await dio.get(url).catchError((error) {
        if (error.response.statusCode == 404) {
          return ["not_found"];
        }
        throw error;
      });
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Código para manejar la acción de cierre de sesión
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
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
              )),
          MaterialButton(
              child: Text('Buscar Libro'),
              onPressed: () {
                if (query != null) {
                  setState(() {});
                }
              }),
          Expanded(
            //`FutureBuilder` para mostrar los resultados obtenidos de la petición HTTP.
            //El `FutureBuilder` tiene un `future` que es el resultado del método `getBooks` y un `builder` -
            //que se encarga de mostrar los resultados en una `ListView`.
            child: FutureBuilder(
                future: query != null ? getBooks('$query') : null,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 1 &&
                        snapshot.data[0] == "not_found") {
                      return Center(child: Text("No se encontró nada"));
                    }
                    searchResults = snapshot.data;
                    if (searchResults != null && searchResults.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          //index = searchResults.length;
                          return ListTile(
                              leading: Text(searchResults[index]['volumeInfo']
                                  ['publishedDate']),
                              title: Text(
                                  searchResults[index]['volumeInfo']['title']),
                              onTap: () {
                                Navigator.pushNamed(context, '/book',
                                    arguments: searchResults[index]
                                        ['volumeInfo']);
                              },
                              subtitle: Text(searchResults[index]['volumeInfo']
                                  ['authors'][0]),
                              trailing: Container(
                                width: 60.0,
                                height: 60.0,
                                child: searchResults[index]['volumeInfo']
                                                ['imageLinks'] !=
                                            null &&
                                        searchResults[index]['volumeInfo']
                                                ['imageLinks']['thumbnail'] !=
                                            null
                                    ? Image.network(searchResults[index]
                                            ['volumeInfo']['imageLinks']
                                        ['thumbnail'])
                                    : Image.asset("assets/default_image.png"),
                              ));
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
                  }
                  return Container();
                }),
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
    // Se obtiene el argumento pasado al navegar a esta vista
    final Map<String, dynamic> book =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(book['title']), //Se muestra el titulo del libro en la Appbar
      ),
      body: SingleChildScrollView(
        //Se utiliza ScrollView para poder desplazarse por la vista
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        //Se muestra una imagen
                        image: NetworkImage(book['imageLinks'] != null &&
                                book['imageLinks']['thumbnail'] != null
                            ? book['imageLinks']['thumbnail']
                            : 'https://via.placeholder.com/150'),
                        fit: BoxFit.cover))),
            Container(
              margin:
                  EdgeInsets.only(top: 20), //Se agrega un margen de 20 arriba
            ),
            Text(
                book['description'] ??
                    'No hay descripción disponible', //Se muestra la descripción del libro, en caso de no haber, se muestra un mensaje de error
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Text(
                book['publishedDate'] ??
                    'No hay fecha de publicación disponible', //Se muestra la fecha de publicación del libro, en caso de no haber, se muestra un mensaje de error
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
