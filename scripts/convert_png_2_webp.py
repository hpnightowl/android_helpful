#!/usr/bin/env python3
"""
convert_png_to_webp.py
them as VP8X WebP (lossy colour + lossless alpha)

Requires: cwebp (sudo apt install webp)
"""

import subprocess, glob, os, sys
import struct

SEARCH_ROOT     = "com/src/main"
QUALITY         = 100   # lossy colour quality (0-100)
ALPHA_Q         = 100  # 100 = lossless alpha, preserves transparency exactly
DELETE_ORIGINALS = True  # set True to remove the .png after a successful conversion

_ALPHA_COLOUR_TYPES = {4, 6}  # 4 = grey+alpha, 6 = RGBA

def png_has_alpha(path):
    try:
        with open(path, "rb") as f:
            sig = f.read(8)
            if sig != b"\x89PNG\r\n\x1a\n":
                return False          # not a valid PNG
            f.read(4)                 # chunk length
            chunk_type = f.read(4)
            if chunk_type != b"IHDR":
                return False
            ihdr = f.read(13)         # width(4) height(4) bit_depth(1) colour_type(1) ...
            colour_type = ihdr[8]
            return colour_type in _ALPHA_COLOUR_TYPES
    except (OSError, struct.error):
        return False

def check_deps():
    if subprocess.run(["which", "cwebp"], capture_output=True).returncode != 0:
        print("ERROR: 'cwebp' not found. Install with: sudo apt install webp")
        sys.exit(1)

def convert(png_path):
    webp_path = os.path.splitext(png_path)[0] + ".webp"
    result = subprocess.run(
        ["cwebp", "-q", str(QUALITY), "-alpha_q", str(ALPHA_Q), png_path, "-o", webp_path],
        capture_output=True
    )
    if result.returncode != 0:
        return False, webp_path, "cwebp: " + result.stderr.decode().strip()

    if DELETE_ORIGINALS:
        os.remove(png_path)

    return True, webp_path, None

check_deps()

all_pngs   = glob.glob(f"{SEARCH_ROOT}/**/*.png", recursive=True)
alpha_pngs = [f for f in all_pngs if png_has_alpha(f)]

print(f"Scanned {len(all_pngs)} PNG files under {SEARCH_ROOT}/")
print(f"Found {len(alpha_pngs)} with alpha channel.\n")

if not alpha_pngs:
    print("Nothing to convert.")
    sys.exit(0)

print(f"Converting to VP8X WebP (q={QUALITY}, alpha_q={ALPHA_Q})...\n")

success, failed = 0, []

for i, png in enumerate(alpha_pngs, 1):
    ok, webp, err = convert(png)
    label = png.replace(SEARCH_ROOT + "/", "")
    if ok:
        success += 1
        kept = "" if DELETE_ORIGINALS else "  (PNG kept)"
        print(f"  [{i:3d}/{len(alpha_pngs)}] OK   {label}{kept}")
    else:
        failed.append((png, err))
        print(f"  [{i:3d}/{len(alpha_pngs)}] FAIL {label} — {err}")

print(f"\nResult: {success} converted, {len(failed)} failed.")
if failed:
    print("\nFailed files:")
    for path, reason in failed:
        print(f"  {path}  ({reason})")
    sys.exit(1)
