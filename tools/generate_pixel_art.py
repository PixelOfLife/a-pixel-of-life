#!/usr/bin/env python3
"""
Pixel Art Generator for "A Pixel of Life"
Generates sprites programmatically based on game design specs.
"""

import os
import math
import random
from PIL import Image, ImageDraw

OUTPUT_DIR = "assets/sprites"
os.makedirs(OUTPUT_DIR, exist_ok=True)

PALETTE = {
    # Fondo: negro absoluto a azul muy oscuro
    "bg_darkest": (5, 5, 15),          # Casi negro absoluto
    "bg_dark": (15, 20, 35),           # Azul muy oscuro
    "bg_medium": (25, 35, 55),         # Azul oscuro medio
    
    # Célula: sombras grises a blancos (sensación de luz tenue)
    "cell_shadow": (40, 45, 55),        # Gris oscuro
    "cell_mid": (80, 90, 100),          # Gris medio
    "cell_light": (150, 160, 170),      # Gris claro
    "cell_bright": (220, 225, 235),     # Casi blanco
    
    # Núcleo: único punto de luz (blanco puro)
    "nucleus": (255, 255, 255),          # Blanco puro
    "nucleus_glow": (200, 210, 220),    # Blanco azulado
    
    # Emociones (minimalismo):
    "calm_blue": (60, 80, 120),         # Azul frío (calma)
    "warm_hint": (180, 140, 100),       # Sombra cálida mínima (alegría)
    "tense_red": (80, 50, 50),          #Rojo oscuro mínimo (tensión)
}

def save_sprite(data, filename, size=(16, 16)):
    """Save sprite data as PNG"""
    img = Image.new("RGBA", size, (0, 0, 0, 0))
    pixels = img.load()
    
    transparent = (0, 0, 0, 0)
    
    for y, row in enumerate(data):
        for x, color in enumerate(row):
            if color == "transparent":
                pixels[x, y] = transparent
            elif color:
                # Handle alpha in color tuple
                if len(color) == 4:
                    pixels[x, y] = color
                else:
                    pixels[x, y] = color + (255,)
    
    filepath = os.path.join(OUTPUT_DIR, filename)
    img.save(filepath)
    print(f"Generated: {filepath}")
    
    filepath = os.path.join(OUTPUT_DIR, filename)
    img.save(filepath)
    print(f"Generated: {filepath}")

def generate_cell_idle():
    """Generates 4-frame breathing animation for the cell - circular, deep underwater feel"""
    frames = []
    sizes = [10, 12, 14, 12]  
    
    for i, size in enumerate(sizes):
        data = [["transparent" for _ in range(16)] for _ in range(16)]
        center = 8
        
        # Dibujar célula más circular usando círculos concéntricos
        
        # Capa exterior - sombra muy sutil
        for dy in range(-7, 8):
            for dx in range(-7, 8):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 7:
                    alpha = max(0, 25 - int(dist * 4))
                    if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                        if dist > 6:
                            data[center+dy][center+dx] = (*PALETTE["cell_shadow"][:3], alpha)
        
        # Segundo círculo - gris oscuro
        for dy in range(-6, 7):
            for dx in range(-6, 7):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 6:
                    alpha = max(0, 60 - int(dist * 10))
                    if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                        if dist > 5:
                            data[center+dy][center+dx] = (*PALETTE["cell_shadow"][:3], alpha)
        
        # Tercer círculo - gris medio
        for dy in range(-5, 6):
            for dx in range(-5, 6):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 5:
                    alpha = max(0, 100 - int(dist * 15))
                    if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                        if dist > 4:
                            data[center+dy][center+dx] = (*PALETTE["cell_mid"][:3], alpha)
        
        # Cuarto círculo - gris claro (cuerpo principal)
        for dy in range(-4, 5):
            for dx in range(-4, 5):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 4:
                    alpha = max(0, 140 - int(dist * 20))
                    if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                        if dist > 3:
                            data[center+dy][center+dx] = (*PALETTE["cell_light"][:3], alpha)
        
        # Quinto círculo - más claro
        for dy in range(-3, 4):
            for dx in range(-3, 4):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 3:
                    if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                        if dist > 2:
                            data[center+dy][center+dx] = PALETTE["cell_light"]
        
        # Núcleo - punto de luz blanco
        for dy in range(-2, 2):
            for dx in range(-2, 2):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 1.5:
                    if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                        data[center+dy][center+dx] = PALETTE["nucleus"]
        
        frames.append(data)
        save_sprite(data, f"cell_idle_{i+1:02d}.png")
    
    return frames

def generate_cell_appear():
    """6-frame appear animation - circular cell appearing"""
    sizes = [2, 4, 6, 8, 10, 12]
    
    for i, size in enumerate(sizes):
        data = [["transparent" for _ in range(16)] for _ in range(16)]
        center = 8
        
        scale = size / 16.0
        for dy in range(-7, 8):
            for dx in range(-7, 8):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= 7 and 0 <= center+dx < 16 and 0 <= center+dy < 16:
                    scaled_dist = dist * (12.0 / max(size, 1))
                    if scaled_dist < 7:
                        if scaled_dist < 1.5:
                            data[center+dy][center+dx] = PALETTE["nucleus"]
                        elif scaled_dist < 3:
                            data[center+dy][center+dx] = PALETTE["cell_bright"]
                        elif scaled_dist < 5:
                            data[center+dy][center+dx] = PALETTE["cell_light"]
                        else:
                            data[center+dy][center+dx] = PALETTE["cell_mid"]
        
        save_sprite(data, f"cell_appear_{i+1:02d}.png")

def generate_cell_dissolve():
    """8-frame dissolve animation (expand and fade)"""
    sizes = [16, 20, 24, 28, 32, 36, 40, 44]
    alphas = [200, 160, 130, 100, 80, 60, 40, 25]
    
    for i, (size, alpha) in enumerate(zip(sizes, alphas)):
        data = [["transparent" for _ in range(48)] for _ in range(48)]
        center = 24
        
        # Draw dissolving ring - gris oscuro
        for dy in range(-size//2, size//2):
            for dx in range(-size//2, size//2):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= size/2 and 0 <= center+dx < 48 and 0 <= center+dy < 48:
                    if dist > size/2 - 3:
                        color = (*PALETTE["cell_mid"][:3], alpha)
                        data[center+dy][center+dx] = color
                    else:
                        color = (*PALETTE["cell_light"][:3], alpha)
                        data[center+dy][center+dx] = color
        
        save_sprite(data, f"cell_dissolve_{i+1:02d}.png", (48, 48))

def generate_heartbeat_ring():
    """3-frame pulse ring - oscuro/grises"""
    sizes = [3, 16, 32]
    colors = [PALETTE["cell_light"], PALETTE["cell_mid"], PALETTE["cell_shadow"]]
    
    for i, (size, color) in enumerate(zip(sizes, colors)):
        data = [["transparent" for _ in range(48)] for _ in range(48)]
        center = 24
        
        # Draw ring - más sutil que antes
        thickness = 2 if i == 0 else 2
        for dy in range(-size//2, size//2):
            for dx in range(-size//2, size//2):
                dist = (dx**2 + dy**2) ** 0.5
                if 0 <= center+dx < 48 and 0 <= center+dy < 48:
                    if abs(dist - size/2) < thickness:
                        # Alpha más bajo para que sea sutil
                        alpha = max(30, 100 - int(dist))
                        data[center+dy][center+dx] = (*color[:3], alpha)
        
        save_sprite(data, f"heartbeat_ring_{i+1:02d}.png", (48, 48))

def generate_particles():
    """Generate particle variants - casi invisibles"""
    particles = [
        ((2, 2), PALETTE["cell_bright"]),  # Pequeño punto blanco
        ((1, 1), PALETTE["cell_light"]),   # Gris claro mínimo
        ((1, 1), (255, 255, 255)),         # Un punto blanco
        ((1, 1), PALETTE["calm_blue"]),    # Azul frío mínimo
    ]
    
    for i, ((w, h), color) in enumerate(particles):
        data = [["transparent" for _ in range(4)] for _ in range(4)]
        for dy in range(h):
            for dx in range(w):
                if dx < 4 and dy < 4:
                    data[dy][dx] = (*color[:3], 180)  # Slightly transparent
        save_sprite(data, f"particle_{i+1:02d}.png", (4, 4))

def generate_background_tile():
    """Generate subtle background tile - muy oscuro"""
    data = [[PALETTE["bg_darkest"] for _ in range(32)] for _ in range(32)]
    
    # Add casi imperceptible de gradiente
    for y in range(32):
        for x in range(32):
            # Gradiente muy sutil de centro
            dist = ((x-16)**2 + (y-16)**2) ** 0.5
            if dist < 15:
                noise = random.randint(-5, 5)
                r = max(0, min(255, PALETTE["bg_darkest"][0] + noise))
                g = max(0, min(255, PALETTE["bg_darkest"][1] + noise))
                b = max(0, min(255, PALETTE["bg_darkest"][2] + noise))
                data[y][x] = (r, g, b)
    
    save_sprite(data, "bg_tile.png", (32, 32))

if __name__ == "__main__":
    print("Generating pixel art assets for A Pixel of Life...")
    print("=" * 50)
    
    generate_cell_idle()
    print("✓ Cell idle animation (4 frames)")
    
    generate_cell_appear()
    print("✓ Cell appear animation (6 frames)")
    
    generate_cell_dissolve()
    print("✓ Cell dissolve animation (8 frames)")
    
    generate_heartbeat_ring()
    print("✓ Heartbeat rings (3 frames)")
    
    generate_particles()
    print("✓ Particles (5 variants)")
    
    generate_background_tile()
    print("✓ Background tile")
    
    print("=" * 50)
    print(f"All assets saved to: {OUTPUT_DIR}")
    print("Total: ~30KB of pixel art")