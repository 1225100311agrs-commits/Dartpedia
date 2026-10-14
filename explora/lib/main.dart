// Importa los widgets de Material Design.
import 'package:flutter/material.dart';

// ---------- COLORES DE LA APP ----------
const Color colorFondo = Color(0xFFFBF3E4); // crema
const Color colorAzul = Color(0xFF1F4E9C); // azul talavera
const Color colorBoton = Color(0xFF2F63B8);

void main() {
  runApp(const MyApp());
}

// ---------- MODELOS ----------
// Cada elemento (artesanía o lugar) guarda sus datos en un objeto.
class Elemento {
  final String nombre;
  final String imagen; // ruta en assets (opcional)
  final Color color;
  final String descripcion;
  final String horario;
  final String entrada;

  const Elemento({
    required this.nombre,
    required this.imagen,
    required this.color,
    required this.descripcion,
    this.horario = '',
    this.entrada = '',
  });
}

// Seis artesanías para la cuadrícula de la pantalla de inicio.
const List<Elemento> artesanias = [
  Elemento(
    nombre: 'Talavera',
    imagen: 'assets/images/talavera.png',
    color: Color(0xFFF3C6D3),
    descripcion: 'Cerámica pintada a mano con diseños azules y blancos.',
  ),
  Elemento(
    nombre: 'Parroquia',
    imagen: 'assets/images/parroquia.png',
    color: Color(0xFFE9B7A0),
    descripcion: 'Una de las joyas arquitectónicas de la ciudad.',
  ),
  Elemento(
    nombre: 'Textiles',
    imagen: 'assets/images/textiles.png',
    color: Color(0xFFF2D9A6),
    descripcion: 'Cobijas y sarapes tejidos con colores vivos.',
  ),
  Elemento(
    nombre: 'Piel',
    imagen: 'assets/images/piel.png',
    color: Color(0xFFE6C7A5),
    descripcion: 'Carteras y bolsas de piel trabajadas por artesanos.',
  ),
  Elemento(
    nombre: 'Juguetes',
    imagen: 'assets/images/juguetes.png',
    color: Color(0xFFB9D6A0),
    descripcion: 'Juguetes tradicionales de madera y barro.',
  ),
  Elemento(
    nombre: 'Figuras',
    imagen: 'assets/images/figuras.png',
    color: Color(0xFFD6B8E6),
    descripcion: 'Figuras de barro y muñecas hechas a mano.',
  ),
];

// Lugar principal que se muestra en la pantalla de detalle.
const Elemento parroquia = Elemento(
  nombre: 'Parroquia de Nuestra Señora de los Dolores',
  imagen: 'assets/images/parroquia.png',
  color: Color(0xFFE9B7A0),
  descripcion:
      'Uno de los lugares históricos más importantes de Dolores Hidalgo, '
      'Guanajuato. Su arquitectura destaca por sus grandes torres, '
      'fachada de estilo barroco y detalles ornamentales.',
  horario: '9:00 a 18:00',
  entrada: 'Gratuita',
);

// ---------- APP ----------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explora',
      theme: ThemeData(
        scaffoldBackgroundColor: colorFondo,
        colorScheme: ColorScheme.fromSeed(seedColor: colorAzul),
        useMaterial3: true,
      ),
      // En el navegador limita el ancho para que se vea como un celular.
      builder: (context, child) => Container(
        color: const Color(0xFFEADFCB),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: child,
          ),
        ),
      ),
      home: const PantallaInicio(),
    );
  }
}

// Muestra la imagen del asset; si no existe, deja el espacio vacío.
Widget imagenOIcono(Elemento e, {double size = 48, BoxFit fit = BoxFit.cover}) {
  return Image.asset(
    e.imagen,
    fit: fit,
    width: double.infinity,
    height: double.infinity,
    errorBuilder: (context, error, stack) => const Center(),
  );
}

// ---------- TÍTULO "EXPLORA" CON LA E ILUSTRADA ----------
// La imagen logo_e.png reemplaza la primera letra del nombre.
class TituloExplora extends StatelessWidget {
  const TituloExplora({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/logo_e.png',
          height: 48,
          // Si la imagen no existe, muestra una E normal.
          errorBuilder: (context, error, stack) => const Text(
            'E',
            style: TextStyle(
              color: colorAzul,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // La base del texto se alinea con la base de la E.
        Transform.translate(
          offset: const Offset(-2, 5),
          child: const Text(
            'xplora',
            style: TextStyle(
              color: colorAzul,
              fontSize: 30,
              height: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------- PANTALLA 1: INICIO (EXPLORA) ----------
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorFondo,
        toolbarHeight: 64,
        title: const TituloExplora(),
        actions: const [
          Icon(Icons.search, color: colorAzul),
          SizedBox(width: 12),
          Icon(Icons.menu, color: colorAzul),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Cuadrícula de 2 columnas con las artesanías.
            Expanded(
              child: GridView.builder(
                itemCount: artesanias.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, i) {
                  final e = artesanias[i];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(color: e.color, child: imagenOIcono(e)),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Botón EMPEZAR: pasa a la pantalla 2.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PantallaLugares()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorBoton,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('EMPEZAR'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- PANTALLA 2: LUGARES Y ARTESANÍAS ----------
class PantallaLugares extends StatelessWidget {
  const PantallaLugares({super.key});

  // Bloque reutilizable: título, imagen y botón "VER MÁS".
  Widget _seccion(
    BuildContext context,
    String titulo,
    Elemento e,
    VoidCallback alPresionar,
  ) {
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: colorAzul,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: e.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorAzul, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: imagenOIcono(e, size: 64),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: alPresionar,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorBoton,
            foregroundColor: Colors.white,
          ),
          child: const Text('VER MÁS →'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorFondo,
        iconTheme: const IconThemeData(color: colorAzul),
        toolbarHeight: 64,
        title: const TituloExplora(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // LUGARES -> abre el detalle de la parroquia.
            _seccion(context, 'LUGARES', parroquia, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PantallaDetalle(lugar: parroquia),
                ),
              );
            }),
            const SizedBox(height: 24),
            // ARTESANÍAS -> abre el detalle de la primera artesanía.
            _seccion(context, 'ARTESANÍAS', artesanias[0], () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PantallaDetalle(lugar: artesanias[0]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ---------- PANTALLA 3: DETALLE DEL LUGAR ----------
class PantallaDetalle extends StatefulWidget {
  final Elemento lugar; // dato recibido por Navigator

  const PantallaDetalle({super.key, required this.lugar});

  @override
  State<PantallaDetalle> createState() => _PantallaDetalleState();
}

class _PantallaDetalleState extends State<PantallaDetalle> {
  bool _favorito = false; // cambia con setState al tocar el corazón

  // Tarjeta pequeña con ícono, título y valor (Horario / Entrada).
  Widget _dato(IconData icono, String titulo, String valor) {
    return Column(
      children: [
        Icon(icono, color: colorAzul, size: 32),
        const SizedBox(height: 4),
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(valor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.lugar;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen destacada con botón de regreso y favorito encima.
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Container(
                    color: l.color,
                    child: imagenOIcono(l, size: 90),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: colorAzul,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              _favorito
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                setState(() => _favorito = !_favorito),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    l.nombre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: colorAzul,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(l.descripcion, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  // Horario y entrada (solo si el elemento los tiene).
                  if (l.horario.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _dato(Icons.access_time, 'Horario', l.horario),
                        _dato(Icons.confirmation_number, 'Entrada', l.entrada),
                      ],
                    ),
                  const SizedBox(height: 20),
                  // Espacio del mapa (simulado con un contenedor).
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.location_on,
                        size: 48,
                        color: colorAzul,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
