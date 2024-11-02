import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:flutter/material.dart';

class BookForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Book book;

  BookForm({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("nome")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("description")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("categoria")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("autor")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("paginas totais")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("paginas lidas")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("status livro")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("favorito")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("notes")),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("avaliação")),
              ),
            ],
          )),
    );
  }
}
