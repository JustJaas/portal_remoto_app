import 'package:flutter/material.dart';

class CharacterSearchField extends StatefulWidget {
  const CharacterSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<CharacterSearchField> createState() => _CharacterSearchFieldState();
}

class _CharacterSearchFieldState extends State<CharacterSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    widget.onChanged(value);
    setState(() {}); // para mostrar u ocultar el botón de limpiar
  }

  void _clear() {
    _controller.clear();
    _handleChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: 'Buscar personaje por nombre',
      leading: const Icon(Icons.search),
      trailing: <Widget>[
        if (_controller.text.isNotEmpty)
          IconButton(icon: const Icon(Icons.close), onPressed: _clear),
      ],
      onChanged: _handleChanged,
    );
  }
}
