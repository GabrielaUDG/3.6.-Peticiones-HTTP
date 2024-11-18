import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _pokemonData;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPokemonData('pikachu'); // Obtiene los datos de Pikachu al iniciar
  }

  Future<void> _fetchPokemonData(String name) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final data = await _apiService.fetchPokemon(name);
      setState(() {
        _pokemonData = data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Info'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Muestra un spinner mientras carga
            : _errorMessage.isNotEmpty
                ? Text(_errorMessage) // Muestra el mensaje de error si ocurre
                : _pokemonData == null
                    ? const Text('No se encontraron datos.')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nombre: ${_pokemonData!['name']}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Image.network(
                            _pokemonData!['sprites']['front_default'],
                            height: 150,
                            width: 150,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Peso: ${_pokemonData!['weight']}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
      ),
    );
  }
}