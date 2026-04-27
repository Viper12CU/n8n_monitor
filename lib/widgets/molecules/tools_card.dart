import 'package:flutter/material.dart';

// Constantes de configuración
const double _defaultCardHeight = 200;
const double _singleCardHeightMultiplier = 0.68;
const double _singleCardExpansionMultiplier = 0.25;
const double _defaultSplitRatio = 0.5;
const Color _defaultLeftColor = Color(0xFF2d5540);
const Duration _animationDuration = Duration(milliseconds: 300);
const Duration _singleLongPressDuration = Duration(seconds: 1);
const Duration _doubleLongPressDuration = Duration(seconds: 2);

enum ToolsCardVariant { single, double }

/// Widget reusable para presentar opciones con animaciones y diseño trapezoid.
/// 
/// Soporta dos variantes:
/// - [ToolsCardVariant.single]: Un único contenedor con expansión en long press
/// - [ToolsCardVariant.double]: Dos trapecios con descripciones animadas
class ToolsCard extends StatefulWidget {
  final ToolsCardVariant variant;
  final double height;
  final Color? leftColor;
  final Color? rightColor;
  final IconData leftIcon;
  final IconData rightIcon;
  final String leftTitle;
  final String rightTitle;
  final String leftDescription;
  final String rightDescription;
  final String centerTitle;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;
  final VoidCallback? onLeftLongPress;
  final VoidCallback? onRightLongPress;

  const ToolsCard({
    super.key,
    this.variant = ToolsCardVariant.double,
    this.height = _defaultCardHeight,
    this.leftColor,
    this.rightColor,
    this.leftIcon = Icons.build,
    this.rightIcon = Icons.settings,
    this.leftTitle = "Herramientas",
    this.rightTitle = "Configuración",
    this.leftDescription = "Gestiona tus herramientas",
    this.rightDescription = "Ajusta la configuración",
    this.centerTitle = "Herramientas",
    this.onLeftTap,
    this.onRightTap,
    this.onLeftLongPress,
    this.onRightLongPress,
  });

  @override
  State<ToolsCard> createState() => _ToolsCardState();
}

class _ToolsCardState extends State<ToolsCard> with TickerProviderStateMixin {
  // Estados de presión para cada lado
  bool isLeftPressed = false;
  bool isRightPressed = false;

  // Controladores de animación
  late AnimationController _leftController;
  late AnimationController _rightController;
  late AnimationController _titleController;

  @override
  void initState() {
    super.initState();
    _initializeAnimationControllers();
  }

  /// Inicializa todos los controladores de animación con la duración configurada
  void _initializeAnimationControllers() {
    _leftController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _rightController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _titleController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  /// Sincroniza la animación del título central con el estado de presión
  void _syncTitleAnimation() {
    final shouldShowTitle =
        isLeftPressed || (widget.variant == ToolsCardVariant.double && isRightPressed);
    
    if (shouldShowTitle) {
      _titleController.forward();
    } else {
      _titleController.reverse();
    }
  }

  bool get _isDouble => widget.variant == ToolsCardVariant.double;

  /// Construye el contenedor simple con expansión en long press (modo single)
  Widget _buildSingleContainer(BuildContext context) {
    return SingleToolContainer(
      onTap: widget.onLeftTap,
      onLongPress: _handleSingleLongPress,
      color: widget.leftColor ?? _defaultLeftColor,
      icon: widget.leftIcon,
      title: widget.leftTitle,
      description: widget.leftDescription,
    );
  }

  /// Maneja el evento de long press para la variante single
  void _handleSingleLongPress() {
    if (isLeftPressed) return; // Evita múltiples presses mientras se anima

    setState(() => isLeftPressed = true);
    _leftController.forward();
    widget.onLeftLongPress?.call();

    // Retroceso automático después de 1 segundo
    Future.delayed(_singleLongPressDuration, () {
      if (mounted && isLeftPressed) {
        setState(() => isLeftPressed = false);
        _leftController.reverse();
      }
    });
  }

  /// Construye los dos contenedores trapezoidales (modo double)
  List<Widget> _buildDoubleContainers() {
    return [
      _buildLeftTrapezoid(),
      _buildRightTrapezoid(),
    ];
  }

  /// Construye el trapecio izquierdo con sus animaciones
  Widget _buildLeftTrapezoid() {
    return AnimatedBuilder(
      animation: _leftController,
      builder: (context, child) {
        return TrapecioContainer(
          onTap: widget.onLeftTap,
          onLongPress: () => _handleDoubleLongPress(true),
          color: widget.leftColor ?? _defaultLeftColor,
          position: TrapecioContainerPosition.left,
          icon: widget.leftIcon,
          title: widget.leftTitle,
          description: widget.leftDescription,
          showDescription: isLeftPressed,
          animationValue: _leftController.value,
        );
      },
    );
  }

  /// Construye el trapecio derecho con sus animaciones
  Widget _buildRightTrapezoid() {
    return AnimatedBuilder(
      animation: _rightController,
      builder: (context, child) {
        return TrapecioContainer(
          onTap: widget.onRightTap,
          onLongPress: () => _handleDoubleLongPress(false),
          color: widget.rightColor ?? Theme.of(context).colorScheme.secondary,
          position: TrapecioContainerPosition.right,
          icon: widget.rightIcon,
          title: widget.rightTitle,
          description: widget.rightDescription,
          showDescription: isRightPressed,
          animationValue: _rightController.value,
        );
      },
    );
  }

  /// Maneja el evento de long press para la variante double
  /// [isLeft] indica si es el trapecio izquierdo o derecho
  void _handleDoubleLongPress(bool isLeft) {
    setState(() {
      if (isLeft) {
        isLeftPressed = !isLeftPressed;
        if (isLeftPressed) {
          isRightPressed = false;
          _rightController.reverse();
        }
      } else {
        isRightPressed = !isRightPressed;
        if (isRightPressed) {
          isLeftPressed = false;
          _leftController.reverse();
        }
      }
    });

    final controller = isLeft ? _leftController : _rightController;
    final isPressed = isLeft ? isLeftPressed : isRightPressed;

    if (isPressed) {
      controller.forward();

      // Retroceso automático después de 2 segundos
      Future.delayed(_doubleLongPressDuration, () {
        if (mounted && (isLeft ? isLeftPressed : isRightPressed)) {
          setState(() {
            if (isLeft) {
              isLeftPressed = false;
            } else {
              isRightPressed = false;
            }
          });
          controller.reverse();
          _syncTitleAnimation();
        }
      });
    } else {
      controller.reverse();
    }

    _syncTitleAnimation();
    (isLeft ? widget.onLeftLongPress : widget.onRightLongPress)?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      child: AnimatedBuilder(
        animation: _leftController,
        builder: (context, child) => SizedBox(
          height: _calculateCardHeight(),
          child: child,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isDouble) ..._buildDoubleContainers() else _buildSingleContainer(context),
            if (_isDouble) _buildCenterTitle(),
          ],
        ),
      ),
    );
  }

  /// Calcula la altura de la tarjeta según la variante y animación
  double _calculateCardHeight() {
    if (_isDouble) return widget.height;
    return widget.height * (_singleCardHeightMultiplier + (_singleCardExpansionMultiplier * _leftController.value));
  }

  /// Construye el título central animado para la variante double
  Widget _buildCenterTitle() {
    return AnimatedBuilder(
      animation: _titleController,
      builder: (context, child) {
        return Positioned(
          top: 60 + (-50 * _titleController.value),
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: 0.7 + (0.3 * _titleController.value),
              child: Text(
                widget.centerTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum TrapecioContainerPosition { right, left }

/// Contenedor simple para la variante single de ToolsCard
/// Presenta un ícono, título y descripción con diseño trapezoid de fondo
class SingleToolContainer extends StatelessWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final Color color;
  final IconData? icon;
  final String? title;
  final String? description;

  const SingleToolContainer({
    super.key,
    required this.color,
    this.onTap,
    this.onLongPress,
    this.icon,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIconBadge(context),
            if (title != null) _buildTitle(context),
            if (description != null && description!.isNotEmpty) _buildDescription(context),
          ],
        ),
      ),
    );
  }

  /// Construye el contenedor del ícono con estilo glass
  Widget _buildIconBadge(BuildContext context) {
    if (icon == null) return const SizedBox.shrink();
    
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 255, 255, 255),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: const Color.fromARGB(46, 255, 255, 255),
          width: 1.0,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 26, color: Colors.white),
    );
  }

  /// Construye el widget del título
  Widget _buildTitle(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ) ?? const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        );

    return Text(title!, style: titleStyle);
  }

  /// Construye el contenedor expandible de la descripción
  Widget _buildDescription(BuildContext context) {
    final descriptionStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: const Color.fromARGB(240, 255, 255, 255),
          fontWeight: FontWeight.w500,
          height: 1.35,
        ) ?? const TextStyle(
          color: Color.fromARGB(240, 255, 255, 255),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.35,
        );

    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(20, 0, 0, 0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(description!, style: descriptionStyle),
      ),
    );
  }
}

/// Contenedor trapezoid animado para la variante double de ToolsCard
/// Muestra un ícono + título normalmente, y descripción al hacer long press
class TrapecioContainer extends StatelessWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final TrapecioContainerPosition position;
  final Color color;
  final Widget? child;
  final IconData? icon;
  final String? title;
  final String? description;
  final bool showDescription;
  final double animationValue;
  final double splitRatio;

  const TrapecioContainer({
    super.key,
    required this.color,
    this.child,
    required this.position,
    this.onTap,
    this.onLongPress,
    this.icon,
    this.title,
    this.description,
    this.showDescription = false,
    this.animationValue = 0.0,
    this.splitRatio = _defaultSplitRatio,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      clipper: position == TrapecioContainerPosition.right
          ? TrapecioRectoClipperRight(splitRatio)
          : TrapecioRectoClipperLeft(splitRatio),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: _buildContainerContent(context),
      ),
    );
  }

  /// Construye el contenido interno del contenedor
  Widget _buildContainerContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: _buildBoxDecoration(),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: position == TrapecioContainerPosition.left
            ? Alignment.centerLeft
            : Alignment.centerRight,
        children: [
          _buildIconAndTitle(),
          _buildDescriptionOverlay(),
        ],
      ),
    );
  }

  /// Construye la decoración de la caja (color y bordes redondeados)
  BoxDecoration _buildBoxDecoration() {
    final isLeft = position == TrapecioContainerPosition.left;
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isLeft ? 18 : 0),
        bottomLeft: Radius.circular(isLeft ? 18 : 0),
        topRight: Radius.circular(isLeft ? 0 : 18),
        bottomRight: Radius.circular(isLeft ? 0 : 18),
      ),
    );
  }

  /// Construye el ícono y título con opacidad animada
  Widget _buildIconAndTitle() {
    final textTheme = TextTheme(
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );

    return Opacity(
      opacity: 1.0 - animationValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) _buildIconBadge(),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(title!, style: textTheme.labelLarge),
            ),
        ],
      ),
    );
  }

  /// Construye el contenedor del ícono con estilo glass
  Widget _buildIconBadge() {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 255, 255, 255),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color.fromARGB(46, 255, 255, 255),
          width: 1.0,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 26, color: Colors.white),
    );
  }

  /// Construye la descripción superpuesta con opacidad animada
  Widget _buildDescriptionOverlay() {
    final isLeft = position == TrapecioContainerPosition.left;
    final descriptionStyle = TextStyle(
      color: const Color.fromARGB(217, 255, 255, 255),
      fontSize: 12,
      height: 1.25,
    );

    return Opacity(
      opacity: animationValue,
      child: Padding(
        padding: isLeft
            ? const EdgeInsets.only(left: 14.0, right: 28.0, top: 14.0, bottom: 14.0)
            : const EdgeInsets.only(left: 28.0, right: 14.0, top: 14.0, bottom: 14.0),
        child: Align(
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120),
            child: Text(
              description ?? '',
              textAlign: isLeft ? TextAlign.left : TextAlign.right,
              style: descriptionStyle,
            ),
          ),
        ),
      ),
    );
  }
}

/// Clipper para crear el patrón trapezoid en el lado derecho
class TrapecioRectoClipperRight extends CustomClipper<Path> {
  final double splitRatio;

  TrapecioRectoClipperRight(this.splitRatio);

  @override
  Path getClip(Size size) {
    final path = Path();
    final topSplit = splitRatio - 0.2;
    final bottomSplit = splitRatio + 0.2;

    path.moveTo(size.width * bottomSplit, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * topSplit, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Clipper para crear el patrón trapezoid en el lado izquierdo
class TrapecioRectoClipperLeft extends CustomClipper<Path> {
  final double splitRatio;

  TrapecioRectoClipperLeft(this.splitRatio);

  @override
  Path getClip(Size size) {
    final path = Path();
    final topSplit = splitRatio - 0.2;
    final bottomSplit = splitRatio + 0.2;

    path.moveTo(0, 0);
    path.lineTo(size.width * topSplit, 0);
    path.lineTo(size.width * bottomSplit, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
