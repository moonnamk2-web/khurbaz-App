import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/resources/app_colors.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  int selectedSort = 0;
  bool availableOnly = false;
  bool discountOnly = false;

  final List<_SortOption> sorts = const [
    _SortOption('الأقرب', Icons.near_me_outlined),
    _SortOption('الأرخص', Icons.arrow_downward),
    _SortOption('الأغلى', Icons.arrow_upward),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        body: SafeArea(
          child: Column(
            children: [
              _SearchBar(controller: _controller),
              const SizedBox(height: 8),
              _FiltersBar(
                sorts: sorts,
                selectedSort: selectedSort,
                availableOnly: availableOnly,
                discountOnly: discountOnly,
                onSortChange: (i) => setState(() => selectedSort = i),
                onToggleAvailable: () =>
                    setState(() => availableOnly = !availableOnly),
                onToggleDiscount: () =>
                    setState(() => discountOnly = !discountOnly),
                onOpenFilters: () => _openFilters(context),
              ),
              const SizedBox(height: 12),
              const Expanded(child: _EmptyState()),
            ],
          ),
        ),
      ),
    );
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'فلترة النتائج',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              _BottomFilterRow(
                title: 'متوفر الآن فقط',
                value: availableOnly,
                onChanged: (_) =>
                    setState(() => availableOnly = !availableOnly),
              ),

              _BottomFilterRow(
                title: 'عروض وخصومات',
                value: discountOnly,
                onChanged: (_) => setState(() => discountOnly = !discountOnly),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'تطبيق الفلاتر',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: kMainColor.withOpacity(0.08),
          hintText: 'ابحث عن منتج',
          prefixIcon: const Icon(Icons.search, color: kMainColor),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close, color: kMainColor),
                  onPressed: controller.clear,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _FiltersBar extends StatelessWidget {
  final List<_SortOption> sorts;
  final int selectedSort;
  final bool availableOnly;
  final bool discountOnly;
  final ValueChanged<int> onSortChange;
  final VoidCallback onToggleAvailable;
  final VoidCallback onToggleDiscount;
  final VoidCallback onOpenFilters;

  const _FiltersBar({
    required this.sorts,
    required this.selectedSort,
    required this.availableOnly,
    required this.discountOnly,
    required this.onSortChange,
    required this.onToggleAvailable,
    required this.onToggleDiscount,
    required this.onOpenFilters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          for (int i = 0; i < sorts.length; i++)
            _FilterChip(
              title: sorts[i].title,
              icon: sorts[i].icon,
              active: selectedSort == i,
              onTap: () => onSortChange(i),
            ),

          _FilterChip(
            title: 'متوفر',
            icon: Icons.check_circle_outline,
            active: availableOnly,
            onTap: onToggleAvailable,
          ),

          _FilterChip(
            title: 'خصومات',
            icon: Icons.local_offer_outlined,
            active: discountOnly,
            onTap: onToggleDiscount,
          ),

          _FilterChip(
            title: 'فلترة',
            icon: Icons.tune,
            active: false,
            onTap: onOpenFilters,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip({
    required this.title,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: active ? kMainColor : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: active ? kMainColor : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? Colors.white : kTitleGreyColor,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : kTitleBodyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search, size: 40, color: kMainColor),
          ),
          const SizedBox(height: 16),
          Text(
            'ابحث عن منتجك',
            style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'استخدم البحث أو الفلاتر للوصول السريع',
            style: GoogleFonts.cairo(fontSize: 14, color: kTitleGreyColor),
          ),
        ],
      ),
    );
  }
}

class _SortOption {
  final String title;
  final IconData icon;

  const _SortOption(this.title, this.icon);
}

class _BottomFilterRow extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _BottomFilterRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      activeColor: kMainColor,
      onChanged: onChanged,
      title: Text(title, style: GoogleFonts.cairo(fontSize: 14)),
    );
  }
}
