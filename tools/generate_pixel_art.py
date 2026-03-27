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
    "bg_dark": (26, 10, 46),        # Púrpura oscuro (#1a0a2e)
    "bg_medium": (51, 17, 85),     # Púrpura medio (#331155)
    "cell_glow": (255, 204, 238),   # Rosa muy claro (#ffcc ee)
    "cell_membrane": (255, 153, 204), # Rosa suave (#ff99cc)
    "cell_body": (255, 102, 170),   # Rosa intenso (#ff66aa)
    "nucleus": (255, 245, 238),     # Blanco cálido (#fff5ee)
    "nucleus_glow": (255, 230, 240), # Blanco rosa
    "calm_blue": (153, 204, 255),   # Azul suave (#99ccff)
    "joy_gold": (255, 204, 102),    # Dorado (#ffcc66)
    "distress_red": (204, 51, 51),  # Rojo tenue (#cc3333)
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
    """Generates 4-frame breathing animation for the cell"""
    frames = []
    sizes = [12, 14, 16, 14]  # Breathing pattern
    
    for i, size in enumerate(sizes):
        data = [["transparent" for _ in range(16)] for _ in range(16)]
        center = 8
        
        # Draw glow (outer)
        for dy in range(-size//2 - 2, size//2 + 2):
            for dx in range(-size//2 - 2, size//2 + 2):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= size/2 + 1:
                    alpha = max(0, 80 - int(dist * 15))
                    if (center+dx, center+dy) in [(x,y) for y in range(16) for x in range(16)]:
                        if 0 <= center+dx < 16 and 0 <= center+dy < 16:
                            if dist < size/2 - 1:
                                data[center+dy][center+dx] = PALETTE["cell_glow"]
                            else:
                                data[center+dy][center+dx] = (*PALETTE["cell_glow"][:3], alpha)
        
        # Draw membrane
        for dy in range(-size//2, size//2):
            for dx in range(-size//2, size//2):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= size/2 and 0 <= center+dx < 16 and 0 <= center+dy < 16:
                    if dist > size/2 - 2:
                        data[center+dy][center+dx] = PALETTE["cell_membrane"]
        
        # Draw body
        for dy in range(-size//2 + 1, size//2 - 1):
            for dx in range(-size//2 + 1, size//2 - 1):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= size/2 - 2 and 0 <= center+dx < 16 and 0 <= center+dy < 16:
                    data[center+dy][center+dx] = PALETTE["cell_body"]
        
        # Draw nucleus
        nuc_size = 4 if i % 2 == 0 else 5
        for dy in range(-nuc_size//2, nuc_size//2):
            for dx in range(-nuc_size//2, nuc_size//2):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= nuc_size/2 and 0 <= center+dx < 16 and 0 <= center+dy < 16:
                    data[center+dy][center+dx] = PALETTE["nucleus"]
        
        frames.append(data)
        save_sprite(data, f"cell_idle_{i+1:02d}.png")
    
    return frames

def generate_cell_appear():
    """6-frame appear animation (grow from nothing)"""
    sizes = [2, 4, 8, 12, 14, 16]
    
    for i, size in enumerate(sizes):
        data = [["transparent" for _ in range(16)] for _ in range(16)]
        center = 8
        
        # Scaled-down cell
        scale = size / 16
        for dy in range(-7, 8):
            for dx in range(-7, 8):
                scaled_dx = int(dx * scale)
                scaled_dy = int(dy * scale)
                if abs(scaled_dx) < 8 and abs(scaled_dy) < 8 and 0 <= center+dx < 16 and 0 <= center+dy < 16:
                    dist = (scaled_dx**2 + scaled_dy**2) ** 0.5
                    if dist < 7:
                        if dist < 2:
                            data[center+dy][center+dx] = PALETTE["nucleus"]
                        elif dist < 5:
                            data[center+dy][center+dx] = PALETTE["cell_body"]
                        else:
                            data[center+dy][center+dx] = PALETTE["cell_membrane"]
        
        save_sprite(data, f"cell_appear_{i+1:02d}.png")

def generate_cell_dissolve():
    """8-frame dissolve animation (expand and fade)"""
    sizes = [16, 20, 24, 28, 32, 36, 40, 44]
    alphas = [255, 200, 160, 120, 90, 60, 40, 20]
    
    for i, (size, alpha) in enumerate(zip(sizes, alphas)):
        data = [["transparent" for _ in range(48)] for _ in range(48)]
        center = 24
        
        # Draw dissolving ring
        for dy in range(-size//2, size//2):
            for dx in range(-size//2, size//2):
                dist = (dx**2 + dy**2) ** 0.5
                if dist <= size/2 and 0 <= center+dx < 48 and 0 <= center+dy < 48:
                    if dist > size/2 - 3:
                        color = (*PALETTE["cell_glow"][:3], alpha)
                        data[center+dy][center+dx] = color
                    else:
                        color = (*PALETTE["cell_body"][:3], alpha)
                        data[center+dy][center+dx] = color
        
        save_sprite(data, f"cell_dissolve_{i+1:02d}.png", (48, 48))

def generate_heartbeat_ring():
    """3-frame pulse ring (concentric circles)"""
    sizes = [4, 20, 40]
    colors = [PALETTE["cell_body"], PALETTE["cell_membrane"], PALETTE["cell_glow"]]
    
    for i, (size, color) in enumerate(zip(sizes, colors)):
        data = [["transparent" for _ in range(48)] for _ in range(48)]
        center = 24
        
        # Draw ring
        thickness = 2 if i == 0 else 3
        for dy in range(-size//2, size//2):
            for dx in range(-size//2, size//2):
                dist = (dx**2 + dy**2) ** 0.5
                if 0 <= center+dx < 48 and 0 <= center+dy < 48:
                    if abs(dist - size/2) < thickness:
                        # Edge alpha based on distance from center
                        alpha = max(40, 180 - int(dist * 2))
                        data[center+dy][center+dx] = (*color[:3], alpha)
        
        save_sprite(data, f"heartbeat_ring_{i+1:02d}.png", (48, 48))

def generate_particles():
    """Generate particle variants"""
    particles = [
        ((3, 3), PALETTE["nucleus"]),  # Large glow
        ((2, 2), PALETTE["cell_glow"]),  # Medium
        ((1, 1), (255, 255, 255)),  # Small white
        ((2, 1), PALETTE["calm_blue"]),  # Horizontal
        ((1, 2), PALETTE["calm_blue"]),  # Vertical
    ]
    
    for i, ((w, h), color) in enumerate(particles):
        data = [["transparent" for _ in range(4)] for _ in range(4)]
        for dy in range(h):
            for dx in range(w):
                if dx < 4 and dy < 4:
                    data[dy][dx] = color
        save_sprite(data, f"particle_{i+1:02d}.png", (4, 4))

def generate_background_tile():
    """Generate subtle background tile with gradient"""
    data = [[PALETTE["bg_dark"] for _ in range(32)] for _ in range(32)]
    
    # Add subtle noise/gradient
    for y in range(32):
        for x in range(32):
            dist = ((x-16)**2 + (y-16)**2) ** 0.5
            if dist < 20:
                # Add some variation
                noise = random.randint(-10, 10)
                r = max(0, min(255, PALETTE["bg_dark"][0] + noise))
                g = max(0, min(255, PALETTE["bg_dark"][1] + noise))
                b = max(0, min(255, PALETTE["bg_dark"][2] + noise))
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