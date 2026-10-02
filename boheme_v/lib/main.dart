import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // La fuente debe llamarse igual que en tu pubspec.yaml.
      theme: ThemeData(fontFamily: 'boheme_v'),
      home: const PantallaPrincipal(),
    ),
  );
}

// Modelo: agrupa los datos de cada género en un solo objeto.
class Genero {
  final String nombre;
  final IconData icono;
  final Color color;
  final String descripcion;
  final List<String> libros; // libros recomendados

  const Genero({
    required this.nombre,
    required this.icono,
    required this.color,
    required this.descripcion,
    required this.libros,
  });
}

// Lista con los seis géneros literarios.
const List<Genero> generos = [
  Genero(
    nombre: 'Ciencia ficción',
    icono: Icons.rocket_launch,
    color: Color(0xFFFBC02D),
    descripcion:
        'Explora futuros posibles, viajes espaciales, inteligencia artificial '
        'y avances científicos imaginarios para plantear preguntas sobre el '
        'rumbo de la humanidad.',
    libros: [
      'Dune – Frank Herbert (1965)',
      'Fundación – Isaac Asimov (1951)',
      '¿Sueñan los androides con ovejas eléctricas? – Philip K. Dick (1968)',
      'La mano izquierda de la oscuridad – Ursula K. Le Guin (1969)',
    ],
  ),
  Genero(
    nombre: 'Fantasía',
    icono: Icons.auto_stories,
    color: Color(0xFF8E24AA),
    descripcion:
        'Transporta al lector a mundos mágicos con criaturas, héroes y '
        'reinos imaginarios, donde la magia y las grandes aventuras son parte '
        'de la vida cotidiana.',
    libros: [
      'El Señor de los Anillos – J.R.R. Tolkien (1954-1955)',
      'Harry Potter – J.K. Rowling (1997)',
      'Canción de Hielo y Fuego (Juego de Tronos) – George R.R. Martin (1996)',
    ],
  ),
  Genero(
    nombre: 'Misterio',
    icono: Icons.search,
    color: Color(0xFF1B5E20),
    descripcion:
        'Presenta enigmas, crímenes y secretos que se resuelven poco a poco '
        'a través de pistas, sospechosos y giros inesperados.',
    libros: [
      'Asesinato en el Orient Express – Agatha Christie (1934)',
      'El sabueso de los Baskerville – Arthur Conan Doyle (1902)',
      'Los hombres que no amaban a las mujeres – Stieg Larsson (2005)',
      'La sombra del viento – Carlos Ruiz Zafón (2001)',
    ],
  ),
  Genero(
    nombre: 'Romance',
    icono: Icons.favorite,
    color: Color(0xFFD81B60),
    descripcion:
        'Se centra en las relaciones amorosas y en las emociones de sus '
        'personajes, con historias de encuentros, conflictos y reconciliaciones.',
    libros: [
      'Orgullo y prejuicio – Jane Austen (1813)',
      'Persuasión – Jane Austen (1817)',
      'Al final de la calle 118 – Clara Cortés (2015)',
      'La tregua – Mario Benedetti (1960)',
      'El amor, las mujeres y la vida – Mario Benedetti (1995)',
    ],
  ),
  Genero(
    nombre: 'Histórica',
    icono: Icons.history_edu,
    color: Color(0xFF8D6E63),
    descripcion:
        'Recrea épocas y acontecimientos del pasado, mezclando hechos reales '
        'con personajes y tramas ficticias para entender mejor otras épocas.',
    libros: [
      'El nombre de la rosa – Umberto Eco (1980)',
      'Los pilares de la Tierra – Ken Follett (1989)',
      'Yo, Claudio – Robert Graves (1934)',
      'La catedral del mar – Ildefonso Falcones (2006)',
    ],
  ),
  Genero(
    nombre: 'Terror',
    icono: Icons.dark_mode,
    color: Color(0xFF37474F),
    descripcion:
        'Busca provocar miedo y tensión con elementos sobrenaturales, '
        'atmósferas oscuras y situaciones que ponen a los personajes al límite.',
    libros: [
      'Drácula – Bram Stoker (1897)',
      'Frankenstein – Mary Shelley (1818)',
      'El resplandor – Stephen King (1977)',
      'La llamada de Cthulhu – H.P. Lovecraft (1928)',
    ],
  ),
];

// ====================== PANTALLA 1: CUADRÍCULA ======================
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca de Géneros'),
        centerTitle: true,
      ),
      // GridView.builder crea la cuadrícula a partir de la lista.
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        // 2 columnas con espacio de 16 px entre tarjetas.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85, // proporción ancho/alto de cada tarjeta
        ),
        itemCount: generos.length,
        itemBuilder: (context, index) {
          return TarjetaGenero(genero: generos[index]);
        },
      ),
    );
  }
}

class TarjetaGenero extends StatelessWidget {
  final Genero genero;
  const TarjetaGenero({super.key, required this.genero});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color(0xFFF3F3F8),
      clipBehavior: Clip.antiAlias, // recorta el efecto de toque al borde
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        // Al tocar la tarjeta, abre la pantalla de contenido.
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PantallaContenido(genero: genero),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: genero.color,
                child: Icon(genero.icono, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                genero.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================== PANTALLA 2: CONTENIDO ======================
class PantallaContenido extends StatelessWidget {
  final Genero genero;
  const PantallaContenido({super.key, required this.genero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contenido')),
      // SafeArea evita que el botón quede tapado por la barra de navegación
      // del teléfono.
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            children: [
              // Expanded + scroll: el contenido ocupa el espacio disponible
              // y el botón se queda fijo abajo.
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 58,
                          backgroundColor: genero.color,
                          child: Icon(
                            genero.icono,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        genero.nombre,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        genero.descripcion,
                        style: const TextStyle(fontSize: 18, height: 1.4),
                      ),
                      const SizedBox(height: 28),

                      // ---------- LIBROS RECOMENDADOS ----------
                      Text(
                        'Libros recomendados',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: genero.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // El operador ... (spread) inserta cada elemento
                      // de la lista dentro de los children de la Column.
                      ...genero.libros.map(
                        (libro) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.bookmark,
                                size: 20,
                                color: genero.color,
                              ),
                              const SizedBox(width: 8),
                              // Expanded permite que el texto largo baje
                              // de renglón en lugar de desbordarse.
                              Expanded(
                                child: Text(
                                  libro,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Botón Regresar: Navigator.pop() vuelve a la pantalla anterior.
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Regresar'),
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
