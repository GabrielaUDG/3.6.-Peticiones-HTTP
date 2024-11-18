import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  /// Realiza una solicitud HTTP a la PokeAPI para obtener información de un Pokémon.
  /// 
  /// [name]: El nombre del Pokémon a consultar.
  /// Retorna un mapa con los datos obtenidos.
  Future<Map<String, dynamic>> fetchPokemon(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/$name'));

    if (response.statusCode == 200) {
      // Convierte la respuesta JSON en un mapa
      return jsonDecode(response.body);
    } else {
      // Lanza una excepción si el código de estado no es 200
      throw Exception('Error al obtener datos: ${response.statusCode}');
    }
  }
}