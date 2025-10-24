import 'package:flutter/material.dart';
import './anuncio_model.dart';
import './form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Anuncio> _anuncios = [
    Anuncio(
      titulo: 'Notebook Véi',
      descricao: 'Intel i5, 8GB RAM, SSD 256GB',
      preco: 1000,
    ),
    Anuncio(
      titulo: 'Bicicleta',
      descricao: 'novinha, aro 26 freio a disco',
      preco: 800,
    ),
  ];

  void _adicionarAnuncio() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormScreen()),
    );

    if (resultado != null) {
      setState(() {
        _anuncios.add(resultado['anuncio']);
      });
    }
  }

  void _editarAnuncio(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FormScreen(anuncio: _anuncios[index], index: index),
      ),
    );

    if (resultado != null) {
      setState(() {
        _anuncios[index] = resultado['anuncio'];
      });
    }
  }

  void _removerAnuncio(int index) {
    setState(() {
      _anuncios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Mercado'),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: _anuncios.length,
        itemBuilder: (context, index) {
          final anuncio = _anuncios[index];
          return Dismissible(
            key: Key(anuncio.titulo + index.toString()),
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.edit, color: Colors.white, size: 30),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                _removerAnuncio(index);
              } else {
                _editarAnuncio(index);
              }
            },
            child: Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.image, size: 50),
                title: Text(anuncio.titulo),
                subtitle: Text(anuncio.descricao),
                trailing: Text('R\$ ${anuncio.preco.toStringAsFixed(2)}'),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarAnuncio,
        child: Icon(Icons.add),
      ),
    );
  }
}
