import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './anuncio_model.dart';

class FormScreen extends StatefulWidget {
  final Anuncio? anuncio;
  final int? index;

  FormScreen({this.anuncio, this.index});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _precoController = TextEditingController();
  String? _imagemPath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.anuncio != null) {
      _tituloController.text = widget.anuncio!.titulo;
      _descricaoController.text = widget.anuncio!.descricao;
      _precoController.text = widget.anuncio!.preco.toString();
      _imagemPath = widget.anuncio!.imagemPath;
    }
  }

  Future<void> _selecionarImagem() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Selecionar Imagem', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Câmera'),
              onTap: () => _escolherFonte(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.green),
              title: Text('Galeria'),
              onTap: () => _escolherFonte(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _escolherFonte(ImageSource source) async {
    Navigator.pop(context);
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imagemPath = image.path;
      });
    }
  }

  void _salvar() {
    if (_tituloController.text.isNotEmpty && 
        _descricaoController.text.isNotEmpty && 
        _precoController.text.isNotEmpty) {
      
      final anuncio = Anuncio(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        preco: double.tryParse(_precoController.text) ?? 0.0,
        imagemPath: _imagemPath,
      );
      
      Navigator.pop(context, {'anuncio': anuncio, 'index': widget.index});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anuncio == null ? 'Novo Anúncio' : 'Editar Anúncio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(
                labelText: 'Preço',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _imagemPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              _imagemPath!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_imagemPath!),
                              fit: BoxFit.cover,
                            ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 50, color: Colors.grey),
                        Text('Nenhuma imagem selecionada'),
                      ],
                    ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _selecionarImagem,
              icon: Icon(Icons.photo_library),
              label: Text('Selecionar Imagem'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _salvar,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}