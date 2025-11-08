import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import './anuncio_model.dart';
import './form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Anuncio> _anunciosBox;

  @override
  void initState() {
    super.initState();
    _anunciosBox = Hive.box<Anuncio>('anuncios');
    _adicionarAnunciosIniciais();
  }

  void _adicionarAnunciosIniciais() {
    if (_anunciosBox.isEmpty) {
      _anunciosBox.add(
        Anuncio(
          titulo: 'Notebook Véi',
          descricao: 'Intel i5, 8GB RAM, SSD 256GB',
          preco: 1000,
        ),
      );
      _anunciosBox.add(
        Anuncio(
          titulo: 'Bicicleta',
          descricao: 'novinha, aro 26 freio a disco',
          preco: 800,
        ),
      );
    }
  }

  void _adicionarAnuncio() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormScreen()),
    );

    if (resultado != null) {
      await _anunciosBox.add(resultado['anuncio']);
      setState(() {});
    }
  }

  void _editarAnuncio(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FormScreen(anuncio: _anunciosBox.getAt(index), index: index),
      ),
    );

    if (resultado != null) {
      _anunciosBox.putAt(index, resultado['anuncio']);
      setState(() {});
    }
  }

  void _removerAnuncio(int index) {
    _anunciosBox.deleteAt(index);
    setState(() {});
  }

  void _compartilharAnuncio(Anuncio anuncio) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Compartilhar Anúncio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.message, color: Colors.green),
              title: Text('WhatsApp'),
              onTap: () => _compartilharWhatsApp(anuncio),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('E-mail'),
              onTap: () => _compartilharEmail(anuncio),
            ),
            ListTile(
              leading: Icon(Icons.sms, color: Colors.orange),
              title: Text('SMS'),
              onTap: () => _compartilharSMS(anuncio),
            ),
          ],
        ),
      ),
    );
  }

  void _compartilharWhatsApp(Anuncio anuncio) async {
    final texto = 'Confira este anúncio:\n\n${anuncio.titulo}\n${anuncio.descricao}\nPreço: R\$ ${anuncio.preco.toStringAsFixed(2)}';
    final url = 'https://wa.me/?text=${Uri.encodeComponent(texto)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
    Navigator.pop(context);
  }

  void _compartilharEmail(Anuncio anuncio) async {
    final assunto = 'Anúncio: ${anuncio.titulo}';
    final corpo = 'Confira este anúncio:\n\n${anuncio.titulo}\n${anuncio.descricao}\nPreço: R\$ ${anuncio.preco.toStringAsFixed(2)}';
    final url = 'mailto:?subject=${Uri.encodeComponent(assunto)}&body=${Uri.encodeComponent(corpo)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
    Navigator.pop(context);
  }

  void _compartilharSMS(Anuncio anuncio) async {
    final texto = 'Confira este anúncio: ${anuncio.titulo} - ${anuncio.descricao} - R\$ ${anuncio.preco.toStringAsFixed(2)}';
    final url = 'sms:?body=${Uri.encodeComponent(texto)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Mercado'),
        backgroundColor: Colors.yellow,
      ),
      body: ValueListenableBuilder(
        valueListenable: _anunciosBox.listenable(),
        builder: (context, Box<Anuncio> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final anuncio = box.getAt(index)!;
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
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    _editarAnuncio(index);
                    return false;
                  }
                  return true;
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    _removerAnuncio(index);
                  }
                },
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child: anuncio.imagemPath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: kIsWeb
                                  ? Image.network(
                                      anuncio.imagemPath!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(anuncio.imagemPath!),
                                      fit: BoxFit.cover,
                                    ),
                            )
                          : Icon(Icons.image, size: 50),
                    ),
                    title: Text(anuncio.titulo),
                    subtitle: Text(anuncio.descricao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('R\$ ${anuncio.preco.toStringAsFixed(2)}'),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () => _compartilharAnuncio(anuncio),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
