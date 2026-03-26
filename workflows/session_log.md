# Bitácora del Proyecto: "A Pixel of Life"
## Session Log - Última Actualización: 2026-03-26

---

## VISIÓN GENERAL DEL PROYECTO
Juego Pixel Art RPG sobre desarrollo emocional humano, usando música y ritmo como mecánica central. El jugador experimenta la vida desde la concepción, donde sus elecciones tempranas forman su personalidad base, pero siempre tiene la oportunidad de cambiar.

---

## CONCEPTOS CORE APROBADOS

### Estructura Narrativa
- **Tipo:** Híbrido (lineal con puntos de decisión clave)
- **Mecánica central:** El "Beat" (latido del corazón) como lenguaje
- **Sistema de ramificaciones:** Ligero, basado en valores de temperamento
- **Público:** 6+ años, texto simple y claro

### Sistemas Principales
1. **MusicSystem** - El latido del corazón como primer lenguaje
2. **VibrationSystem** - Vibraciones positivas/negativas/calmas
3. **PersonalityProfile** - Temperamento base + EQ como superpoderes
4. **RippleEffectSystem** - "Lo que das, vuelve" (consecuencias diferidas)
5. **IdleHintSystem** - Anti-aburrimiento, hints cada 5 seg de inactividad

### Mecánicas de Juego
- Presionar al ritmo del corazón (Beat)
- Responder a vibraciones (positivas/negativas/calmas)
- Hacer elecciones que afectan el temperamento
- Combate rítmico contra la oscuridad (jefes finales)
- Inteligencia Emocional = Superpoderes

---

## ESTADO ACTUAL (Checkpoint)

### ✅ COMPLETADO

#### Documentación
- `workflows/game_bible.md` - Biblia del juego completa
- `workflows/chapter1_storytelling.md` - Cap 1 estructurado (7 escenas)
- `workflows/marketing_and_launch.md` - Estrategia comercial y monetización
- `workflows/producer_identity.md` - Identidad "Heartbeat Studios"
- `workflows/ripple_effect_system.md` - Sistema de consecuencias
- `workflows/idle_hint_system.md` - Sistema anti-aburrimiento

#### Agentes (7)
- `agents/asset_manager.md` - Valida y organiza assets
- `agents/narrative_director.md` - Gestiona historia y diálogos
- `agents/store_compliance.md` - Cumplimiento de tiendas
- `agents/quality_assurance.md` - Testing automatizado
- `agents/project_manager.md` - Orquestación general
- `agents/audio_designer.md` - Gestión de audio y BPM
- `agents/ui_architect.md` - Diseño de interfaces

#### Workflows (7)
- `workflows/asset_pipeline.md` - Procesar nuevos assets
- `workflows/chapter_creation.md` - Desarrollar un capítulo
- `workflows/store_submission.md` - Publicar en tiendas
- `workflows/game_development.md` - Desarrollo general
- `workflows/ripple_effect_system.md` - Consecuencias diferidas
- `workflows/idle_hint_system.md` - Anti-aburrimiento
- `workflows/README.md` - Documentación del sistema

#### Sistemas Core (Scripts GDScript)
- `scripts/core/music_system.gd` - Motor del latido
- `scripts/core/personality_profile.gd` - Temperamento y EQ
- `scripts/core/vibration_system.gd` - Vibraciones
- `scripts/ui/heartbeat_visualizer.gd` - UI del corazón

#### Escenas
- `scenes/player.tscn` - Jugador básico
- `scenes/main.tscn` - Escena principal
- `scenes/ui/heartbeat_visualizer.tscn` - Visualizador

#### Configuración
- `project.godot` - Optimizado para pixel art (640x360, nearest filter)
- Estructura de carpetas creada

### ❌ PENDIENTE

#### Tools (Scripts Python)
- `tools/validate_assets.py` - Validar sprites
- `tools/generate_dialogue.py` - Generar diálogos
- `tools/check_store_readiness.py` - Verificar normativas
- `tools/run_tests.py` - Ejecutar tests
- `tools/create_scene.py` - Crear escenas Godot
- `tools/generate_manifest.py` - Crear manifiesto de assets
- `tools/optimize_sprites.py` - Comprimir sprites
- `tools/performance_monitor.py` - Monitorear rendimiento
- `tools/lint_gdscript.py` - Verificar sintaxis GDScript
- `tools/emotion_analyzer.py` - Analizar texto emocional

#### Game Template (Skeleton replicable)
- Estructura de carpetas base
- Configuración `project.godot` reutilizable
- Scripts core reutilizables
- UI base reutilizable

#### Capítulo 1 (Implementación Godot)
- Escenas conectadas
- Mecánicas del Beat funcionando
- Sistema de vibraciones activo
- Cliffhanger implementado

---

## DECISIONES CLAVE TOMADAS

1. **Motor:** Godot 4.4 (GDScript)
2. **Resolución base:** 640x360 (pixel art)
3. **Filtrado:** Nearest (píxeles nítidos)
4. **Estructura narrativa:** Híbrido (lineal + puntos de decisión)
5. **Monetización:** Freemium (Cap 1 gratis, caps 2+ premium)
6. **Productor:** Heartbeat Studios
7. **Público:** 6+ años
8. **Estilo visual:** Pixel art simple (Zelda/Crono Trigger)
9. **Animación:** Ligera en gameplay, pesada en momentos clave

---

## PRÓXIMOS PASOS SUGERIDOS

1. Completar Tools Python (scripts determinísticos)
2. Crear Game Template (skeleton replicable)
3. Implementar Capítulo 1 en Godot
4. Crear assets placeholder
5. Probar gameplay loop
6. Preparar para tiendas (Google Play, Apple App Store)

---

## NOTAS DE SESIÓN

- El usuario aprueba la estructura híbrida con ramificaciones ligeras
- Se prioriza la economía de recursos y rendimiento del host
- Se busca un producto funcional para publicar cuanto antes
- El Capítulo 1 debe ser gratuito como gancho
- Se valora la rejugabilidad sin comprometer la simplicidad

---

*Última actualización: 2026-03-26*
*Estado del proyecto: En desarrollo activo*
*Próximo milestone: Capítulo 1 funcional*
