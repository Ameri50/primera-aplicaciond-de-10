import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final String currentThemeMode;
  final Function(String) onThemeModeChanged;

  const SettingsDialog({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late String selectedTheme;
  bool notificaciones = true;
  bool favoritos = false;
  bool historioBusqueda = true;
  // ignore: non_constant_identifier_names
  bool modo_desarrollador = false;

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.currentThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Configuración",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // SECCIÓN 1: APARIENCIA
                _SectionHeader(
                  title: "Apariencia",
                  icon: Icons.palette_rounded,
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      _ThemeOption(
                        label: "Claro",
                        icon: Icons.light_mode_rounded,
                        isSelected: selectedTheme == "light",
                        onTap: () {
                          setState(() => selectedTheme = "light");
                          widget.onThemeModeChanged("light");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(
                        color: Colors.grey.withValues(alpha: 0.2),
                        height: 0,
                      ),
                      _ThemeOption(
                        label: "Oscuro",
                        icon: Icons.dark_mode_rounded,
                        isSelected: selectedTheme == "dark",
                        onTap: () {
                          setState(() => selectedTheme = "dark");
                          widget.onThemeModeChanged("dark");
                          Navigator.pop(context);
                        },
                      ),
                      Divider(
                        color: Colors.grey.withValues(alpha: 0.2),
                        height: 0,
                      ),
                      _ThemeOption(
                        label: "Automático",
                        icon: Icons.brightness_auto_rounded,
                        isSelected: selectedTheme == "auto",
                        onTap: () {
                          setState(() => selectedTheme = "auto");
                          widget.onThemeModeChanged("auto");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // SECCIÓN 2: NOTIFICACIONES
                _SectionHeader(
                  title: "Notificaciones",
                  icon: Icons.notifications_rounded,
                ),
                const SizedBox(height: 12),
                _ToggleSetting(
                  title: "Notificaciones",
                  subtitle: "Recibe alertas de nuevas IAs",
                  icon: Icons.notifications_active_rounded,
                  value: notificaciones,
                  onChanged: (value) => setState(() => notificaciones = value),
                ),
                const SizedBox(height: 16),

                // SECCIÓN 3: FAVORITOS Y HISTORIAL
                _SectionHeader(title: "Datos", icon: Icons.storage_rounded),
                const SizedBox(height: 12),
                _ToggleSetting(
                  title: "Guardar Favoritos",
                  subtitle: "Guarda tus IAs favoritas",
                  icon: Icons.star_rounded,
                  value: favoritos,
                  onChanged: (value) => setState(() => favoritos = value),
                ),
                const SizedBox(height: 12),
                _ToggleSetting(
                  title: "Historial de Búsqueda",
                  subtitle: "Guarda tu historial de búsquedas",
                  icon: Icons.history_rounded,
                  value: historioBusqueda,
                  onChanged: (value) =>
                      setState(() => historioBusqueda = value),
                ),
                const SizedBox(height: 16),

                // SECCIÓN 4: INFORMACIÓN
                _SectionHeader(title: "Información", icon: Icons.info_rounded),
                const SizedBox(height: 12),
                _InfoTile(
                  title: "Versión",
                  value: "1.0.0",
                  icon: Icons.info_rounded,
                ),
                const SizedBox(height: 12),
                _InfoTile(
                  title: "Total de IAs",
                  value: "20+",
                  icon: Icons.smart_toy_rounded,
                ),
                const SizedBox(height: 12),
                _InfoTile(
                  title: "Desarrollador",
                  value: "Josué",
                  icon: Icons.person_rounded,
                ),
                const SizedBox(height: 16),

                // SECCIÓN 5: MANTENIMIENTO
                _SectionHeader(
                  title: "Mantenimiento",
                  icon: Icons.build_rounded,
                ),
                const SizedBox(height: 12),
                _ActionButton(
                  title: "Limpiar Caché",
                  icon: Icons.delete_outline_rounded,
                  onTap: () => _showDeleteDialog(context, "caché"),
                ),
                const SizedBox(height: 12),
                _ActionButton(
                  title: "Reiniciar Configuración",
                  icon: Icons.refresh_rounded,
                  onTap: () => _showDeleteDialog(context, "configuración"),
                ),
                const SizedBox(height: 16),

                // SECCIÓN 6: DESARROLLADOR
                _SectionHeader(title: "Avanzado", icon: Icons.settings_rounded),
                const SizedBox(height: 12),
                _ToggleSetting(
                  title: "Modo Desarrollador",
                  subtitle: "Habilita funciones experimentales",
                  icon: Icons.code_rounded,
                  value: modo_desarrollador,
                  onChanged: (value) =>
                      setState(() => modo_desarrollador = value),
                ),
                const SizedBox(height: 24),

                // BOTÓN LISTO
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Listo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("¿Limpiar $type?"),
        content: Text("Esta acción no se puede deshacer"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$type limpiado correctamente")),
              );
            },
            child: const Text("Confirmar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.blue : Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue : Colors.white,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Colors.blue
                      : Colors.grey.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleSetting extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final Function(bool) onChanged;

  const _ToggleSetting({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.orange, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: Colors.orange, size: 18),
          ],
        ),
      ),
    );
  }
}