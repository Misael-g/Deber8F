import 'package:flutter/material.dart';

void main() {
  runApp(const FastFoodApp());
}

class FastFoodApp extends StatelessWidget {
  const FastFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Modelo de datos para los productos
class FoodItem {
  final String name;
  final String category;
  final double price;
  final String image;
  
  FoodItem({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });
}

// Página Principal con Drawer y ListView
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  String selectedCategory = 'Todos';
  
  final List<FoodItem> foodItems = [
    FoodItem(name: 'Hamburguesa Clásica', category: 'Hamburguesas', price: 5.99, image: '🍔'),
    FoodItem(name: 'Pizza Pepperoni', category: 'Pizzas', price: 12.99, image: '🍕'),
    FoodItem(name: 'Hot Dog', category: 'Hot Dogs', price: 3.99, image: '🌭'),
    FoodItem(name: 'Papas Fritas', category: 'Acompañamientos', price: 2.99, image: '🍟'),
    FoodItem(name: 'Coca Cola', category: 'Bebidas', price: 1.99, image: '🥤'),
    FoodItem(name: 'Pizza Margarita', category: 'Pizzas', price: 10.99, image: '🍕'),
  ];

  List<FoodItem> get filteredItems {
    if (selectedCategory == 'Todos') return foodItems;
    return foodItems.where((item) => item.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Scaffold - Estructura básica de la pantalla
    return Scaffold(
      // 2. AppBar - Barra superior de la aplicación
      appBar: AppBar(
        title: const Text('Fast Food App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 13. Switch - Para modo oscuro
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      // 3. Drawer - Menú lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '🍔 Fast Food',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tu comida favorita',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Mi Pedido'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Menú Completo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuGridPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      // 4. Column - Organiza widgets verticalmente
      body: Column(
        children: [
          // 8. Padding - Espaciado interno
          Padding(
            padding: const EdgeInsets.all(16.0),
            // 4. Row - Organiza widgets horizontalmente
            child: Row(
              children: [
                const Text(
                  'Categorías:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                // 6. Expanded - Ocupa el espacio disponible
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip('Todos'),
                        _buildCategoryChip('Hamburguesas'),
                        _buildCategoryChip('Pizzas'),
                        _buildCategoryChip('Bebidas'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 6. Expanded - Para que el ListView ocupe el espacio restante
          Expanded(
            // 10. ListView - Lista scrolleable
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                // 7. Container - Caja con decoración
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Text(
                      item.image,
                      style: const TextStyle(fontSize: 40),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item.category),
                    trailing: Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // 12. ElevatedButton - Botón flotante
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderPage()),
          );
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Ver Pedido'),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
          });
        },
        selectedColor: Colors.orange,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

// Página de Pedido con Stack
class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool addCheese = false;
  bool addBacon = false;
  String selectedSize = 'Mediano';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Pedido'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 5. Stack - Apila widgets uno sobre otro
            Stack(
              children: [
                // 7. Container con imagen de fondo
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.orange.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // 8. Center - Centra el contenido
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      children: [
                        const Text(
                          '🍔',
                          style: TextStyle(fontSize: 80),
                        ),
                        // 9. SizedBox - Espacio fijo
                        const SizedBox(height: 10),
                        const Text(
                          'Hamburguesa Clásica',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // 8. Padding con opciones
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personaliza tu pedido:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // 13. Checkbox - Extras
                  CheckboxListTile(
                    title: const Text('Agregar queso extra'),
                    subtitle: const Text('+\$0.50'),
                    value: addCheese,
                    onChanged: (value) {
                      setState(() {
                        addCheese = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Agregar bacon'),
                    subtitle: const Text('+\$1.00'),
                    value: addBacon,
                    onChanged: (value) {
                      setState(() {
                        addBacon = value ?? false;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  const Text(
                    'Tamaño:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  
                  // 13. Radio - Selección de tamaño
                  RadioListTile<String>(
                    title: const Text('Pequeño'),
                    subtitle: const Text('\$5.99'),
                    value: 'Pequeño',
                    groupValue: selectedSize,
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value ?? 'Mediano';
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Mediano'),
                    subtitle: const Text('\$7.99'),
                    value: 'Mediano',
                    groupValue: selectedSize,
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value ?? 'Mediano';
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Grande'),
                    subtitle: const Text('\$9.99'),
                    value: 'Grande',
                    groupValue: selectedSize,
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value ?? 'Mediano';
                      });
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // 12. Diferentes tipos de botones
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Pedido agregado al carrito')),
                            );
                          },
                          child: const Text('Agregar al Carrito'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                    ],
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

// Página con GridView
class MenuGridPage extends StatelessWidget {
  const MenuGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Hamburguesa', 'icon': '🍔', 'price': '\$5.99'},
      {'name': 'Pizza', 'icon': '🍕', 'price': '\$12.99'},
      {'name': 'Hot Dog', 'icon': '🌭', 'price': '\$3.99'},
      {'name': 'Papas', 'icon': '🍟', 'price': '\$2.99'},
      {'name': 'Bebida', 'icon': '🥤', 'price': '\$1.99'},
      {'name': 'Helado', 'icon': '🍦', 'price': '\$2.49'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Completo'),
      ),
      // 11. GridView - Vista en cuadrícula
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['icon']!,
                  style: const TextStyle(fontSize: 60),
                ),
                const SizedBox(height: 8),
                Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['price']!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // 12. TextButton
                TextButton(
                  onPressed: () {},
                  child: const Text('Ordenar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Página de Perfil con TextField
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 8. Align - Alinea el widget
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.shade200,
                  ),
                  child: const Center(
                    child: Text(
                      '👤',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // 14. TextField - Campos de texto
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              
              // 6. Flexible - Similar a Expanded pero más flexible
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perfil actualizado')),
                        );
                      },
                      child: const Text('Guardar Cambios'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}