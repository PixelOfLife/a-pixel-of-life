# Visual Design Guide: "A Pixel of Life"

## Estilo Visual General
**Womb Darkness** - El sentido de la vista NO está desarrollado. Todo es negro, gris, sombra. La唯一 luz es el núcleo de la célula. El sonido es el protagonista.

### Paleta de Colores (Oscura/Gris)
| Color | Hex | Uso |
|---|---|---|
| Negro absoluto | #05050f | Fondo base |
| Azul muy oscuro | #0f1423 | Fondo gradiente |
| Gris oscuro | #282d37 | Sombra de célula |
| Gris medio | #505a64 | Membrana |
| Gris claro | #96a0aa | Cuerpo de célula |
| Blanco suave | #dce1eb | Borde/light |
| Blanco puro | #ffffff | Núcleo (único punto de luz) |
| Azul frío | #3c5078 | Emociones calmar |
| Sombra cálida | #b48c64 | Emociones positivas (mínimo) |
| Rojo oscuro | #503232 | Emociones tensas (mínimo) |

---

## La Célula (Protagonista del Cap 1)

### Referencias Visuales
- **Sky Evocation (Pixilart):** Formas etéreas, gradientes suaves, luz ambiental
- **Immune Cells Pixel Art:** Formas orgánicas, membranas, núcleos brillantes
- **Bioluminescence (PixelJoint):** Glow efectos, colores que emanan luz

### Diseño de la Célula
```
Frame 1 (Respiración - pequeña):
    . . . . . . . .
    . . ░ ░ ░ ░ . .
    . ░ ▓ ▓ ▓ ▓ ░ .
    . ░ ▓ █ █ ▓ ░ .
    . ░ ▓ █ █ ▓ ░ .
    . ░ ▓ ▓ ▓ ▓ ░ .
    . . ░ ░ ░ ░ . .
    . . . . . . . .

Frame 2 (Respiración - grande):
    . . . . . . . . . . . .
    . . ░ ░ ░ ░ ░ ░ ░ ░ . .
    . ░ ░ ▓ ▓ ▓ ▓ ▓ ▓ ░ ░ .
    . ░ ▓ ▓ █ █ █ █ ▓ ▓ ░ .
    . ░ ▓ █ █ ◆ ◆ █ █ ▓ ░ .
    . ░ ▓ █ ◆ ◆ ◆ ◆ █ ▓ ░ .
    . ░ ▓ █ ◆ ◆ ◆ ◆ █ ▓ ░ .
    . ░ ▓ █ █ ◆ ◆ █ █ ▓ ░ .
    . ░ ▓ ▓ █ █ █ █ ▓ ▓ ░ .
    . . ░ ░ ▓ ▓ ▓ ▓ ░ ░ . .
    . . ░ ░ ░ ░ ░ ░ ░ ░ . .
    . . . . . . . . . . . .

Leyenda:
  ░ = Glow exterior (rosa muy claro, semi-transparente)
  ▓ = Membrana (rosa suave)
  █ = Citoplasma (rosa más intenso)
  ◆ = Núcleo (blanco cálido, brilla)
```

### Animaciones Necesarias
| Animación | Frames | Tamaño | Descripción |
|---|---|---|---|
| Idle (respirando) | 4 | 16x16 | Pulso suave, expande/contrae |
| Aparecer | 6 | 16x16 → 24x24 | Crece desde punto |
| Disiparse | 8 | 24x24 → 0 | Se expande y desvanece |

---

## El Heartbeat (Latido)

### Referencias Visuales
- **Water Drop Ripples:** Círculos concéntricos que se expanden
- **Pond Ripples (PixelJoint):** Ondas suaves sobre agua quieta

### Diseño del Anillo de Pulso
```
Frame 1 (nace):
    . . . . . .
    . ░ █ █ ░ .
    . █     █ .
    . █     █ .
    . ░ █ █ ░ .
    . . . . . .

Frame 3 (se expande):
    . . . . . . . . . . . .
    . . . ░ ░ ░ ░ ░ ░ . . .
    . . ░           ░ ░ . .
    . ░               ░ ░ .
    . █                 ░ .
    . █                 ░ .
    . █                 ░ .
    . ░               ░ ░ .
    . . ░           ░ ░ . .
    . . . ░ ░ ░ ░ ░ ░ . . .
    . . . . . . . . . . . .
    . . . . . . . . . . . .

Frame 6 (máximo, se desvanece):
    Bordes más delgados, alpha reducido
```

### Anillos Múltiples
- Anillo 1 (intenso): 4 frames, rosa fuerte
- Anillo 2 (suave): 6 frames, rosa claro, empieza 0.5s después
- Anillo 3 (eco): 8 frames, casi transparente, empieza 1s después

---

## El Entorno (Útero Abstracto)

### Fondo
- No es un "útero" literal
- Espacio oscuro púrpura con partículas de luz flotante
- Como estar dentro de una nebulosa
- Partículas: puntos blancos/rosas que flotan lentamente

### Partículas
```
Tamaño: 1x1 a 3x3 píxeles
Colores: blanco, rosa claro, azul suave
Movimiento: flotación lenta, deriva
Densidad: 20-30 partículas visibles
```

---

## Costo de Almacenamiento

| Asset | Tamaño | Cantidad | Total |
|---|---|---|---|
| Célula idle (16x16) | 1KB/frame | 4 frames | 4KB |
| Célula aparecer | 1.5KB/frame | 6 frames | 9KB |
| Célula disiparse | 2KB/frame | 8 frames | 16KB |
| Anillo pulso | 0.5KB/frame | 6 frames | 3KB |
| Partículas | 0.1KB c/u | 5 variantes | 0.5KB |
| **TOTAL** | | | **~33KB** |

**Conclusión:** Prácticamente cero impacto. Menos que una foto de WhatsApp.

---

## Herramientas para Crear los Assets

| Herramienta | Uso | Link |
|---|---|---|
| **Piskel** | Editor online gratuito | piskelapp.com |
| **Pixilart** | Editor online + comunidad | pixilart.com |
| **Aseprite** | Editor profesional ($20) | aseprite.org |
| **Lospec** | Paletas de colores predefinidas | lospec.com |
