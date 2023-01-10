import 'package:flutter/material.dart';

import 'package:meals_flutter/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String id = 'filters-screen';
  final Map<String, bool> filters;
  final Function saveFilters;

  const FiltersScreen({
    Key? key,
    required this.filters,
    required this.saveFilters,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _glutenFree = widget.filters['gluten'] as bool;
      _vegetarian = widget.filters['vegetarian'] as bool;
      _vegan = widget.filters['vegan'] as bool;
      _lactoseFree = widget.filters['lactose'] as bool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () => widget.saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            }),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Gluten-free'),
                  subtitle: const Text('Only include gluten-free meals'),
                  value: _glutenFree,
                  onChanged: (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegetarian'),
                  subtitle: const Text('Only include vegetarian meals'),
                  value: _vegetarian,
                  onChanged: (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegan'),
                  subtitle: const Text('Only include vegan meals'),
                  value: _vegan,
                  onChanged: (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Lactose-free'),
                  subtitle: const Text('Only include lactose-free meals'),
                  value: _lactoseFree,
                  onChanged: (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
