import 'package:flutter/material.dart';

void main() {
  // Punto de entrada de la app que lanza nuestro widget principal
  runApp(const MiAppContador());
}

// 1. WIDGET SIN ESTADO: Configura el cascarón global de la aplicación (Tema, Títulos)
class MiAppContador extends StatelessWidget {
  const MiAppContador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Quita la banda de "Debug" en la esquina
      title: 'Mi Contador Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Usa las directrices de diseño modernas
      ),
      home: const PantallaContador(), // Define cuál será la pantalla inicial
    );
  }
}

// 2. WIDGET CON ESTADO: Definición del widget mutable
class PantallaContador extends StatefulWidget {
  const PantallaContador({super.key});

  @override
  State<PantallaContador> createState() => _PantallaContadorState();
}

// 3. LA CLASE DE ESTADO: Aquí vive la lógica y las variables que cambian la pantalla
class _PantallaContadorState extends State<PantallaContador> {
  // Variable de estado que almacena el valor numérico actual
  int _contador = 0;

  // Función para aumentar el valor
  void _incrementar() {
    setState(() {
      _contador++;
    });
  }

  // Función para disminuir el valor
  void _decrementar() {
    setState(() {
      _contador--;
    });
  }

  // Función para regresar el valor a cero
  void _reiniciar() {
    setState(() {
      _contador = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        title: const Text('Contador Flutter Pro'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // Cuerpo central de la pantalla
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra verticalmente los elementos
          children: [
            const Text(
              'Valor actual del contador:',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            // Muestra en tiempo real la variable '_contador'
            Text(
              '$_contador',
              style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40), // Espacio intermedio de separación
            // Fila horizontal para agrupar nuestros tres botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra horizontalmente los botones
              children: [
                // BOTÓN DE DECREMENTO (-)
                FloatingActionButton(
                  onPressed: _decrementar,
                  tooltip: 'Restar uno',
                  backgroundColor: Colors.redAccent,
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
                const SizedBox(width: 20), // Separación entre botones
                // BOTÓN DE REINICIO (0)
                FloatingActionButton(
                  onPressed: _reiniciar,
                  tooltip: 'Hacer cero',
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.refresh, color: Colors.white),
                ),
                const SizedBox(width: 20), // Separación entre botones
                // BOTÓN DE INCREMENTO (+)
                FloatingActionButton(
                  onPressed: _incrementar,
                  tooltip: 'Sumar uno',
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
