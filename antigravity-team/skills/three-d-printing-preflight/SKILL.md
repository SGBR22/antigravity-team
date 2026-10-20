---
name: three-d-printing-preflight
description: Preflight validation, mesh inspection, and slicer engineering recommendations for FDM/FFF and SLA 3D printing. Evaluates watertightness, mechanical fit tolerances, material shrinkage (PLA, PETG, ABS, PA-CF), and print orientations.
---

# 3D Printing Preflight & Engineering Skill

Use this skill when preparing 3D models (STL, OBJ, 3MF, STEP) for additive manufacturing, calculating mechanical fit clearances, and choosing printing process parameters.

## 1. Mesh Validation via Python (`trimesh`)

Run this diagnostic script to verify mesh integrity prior to slicing:

```python
import sys
import trimesh

def inspect_mesh_for_3d_printing(stl_path):
    mesh = trimesh.load(stl_path)
    
    is_watertight = mesh.is_watertight
    euler = mesh.euler_number  # 2 for simple closed 2-manifold sphere/torus
    volume_cm3 = mesh.volume / 1000.0  # mm3 to cm3
    bbox = mesh.bounding_box.extents  # [dx, dy, dz] in mm
    
    report = {
        "File": stl_path,
        "Watertight (Manifold)": is_watertight,
        "Euler Characteristic": euler,
        "Volume (cm3)": round(volume_cm3, 3),
        "Bounding Box (X x Y x Z mm)": f"{bbox[0]:.1f} x {bbox[1]:.1f} x {bbox[2]:.1f}",
        "Faces Count": len(mesh.faces),
        "Vertices Count": len(mesh.vertices),
    }
    
    print("=== 3D PRINT PREFLIGHT REPORT ===")
    for k, v in report.items():
        print(f"  {k}: {v}")
        
    if not is_watertight:
        print("[WARNING] Mesh is non-manifold (holes or self-intersections detected). Slicers may generate artifacts.")
        # Attempt autofix
        trimesh.repair.fill_holes(mesh)
        trimesh.repair.fix_winding(mesh)
        trimesh.repair.fix_normals(mesh)
        if mesh.is_watertight:
            repaired_path = stl_path.replace('.stl', '_repaired.stl')
            mesh.export(repaired_path)
            print(f"[REPAIRED] Saved watertight mesh to: {repaired_path}")
            
    return report

if __name__ == "__main__":
    if len(sys.argv) > 1:
        inspect_mesh_for_3d_printing(sys.argv[1])
```

## 2. Engineering Clearances for 3D Printed Assemblies (FDM)

Due to nozzle thermal expansion, polymer shrinkage, and slicing step-rounding, compensate designed clearances:

| Fit Type | Diameter / Gap Allowance ($\Delta d$) | Usage / Application |
|---|---|---|
| **Free / Loose Fit** | $0.40 - 0.50\text{ mm}$ | Sliding shafts, hinges, rotation pins with free movement. |
| **Snug / Push Fit** | $0.15 - 0.25\text{ mm}$ | Removable covers, snap-fit tabs, locating dowels. |
| **Press / Interference Fit** | $0.00 - 0.08\text{ mm}$ | Permanent press-fit pins, heat-set threaded inserts (M3/M4/M5). |
| **Threaded Holes (Printed)** | Oversize internal thread diameter by $+0.2\text{ mm}$ or tap with standard metal tap post-print. |

## 3. Material Shrinkage & Thermal Parameters

| Material | Bed Temp ($^\circ\text{C}$) | Nozzle Temp ($^\circ\text{C}$) | Linear Shrinkage | Chamber Req. | Best Mechanical Strength |
|---|---|---|---|---|---|
| **PLA** | 50 – 60 | 200 – 215 | $\approx 0.2 - 0.3\%$ | Open | High stiffness, brittle under impact |
| **PETG** | 70 – 85 | 230 – 245 | $\approx 0.4 - 0.6\%$ | Open | Excellent layer adhesion, chemical resistance |
| **ABS / ASA** | 100 – 110 | 240 – 260 | $\approx 1.0 - 1.5\%$ | Enclosed! | High temp resistance, UV (ASA), impact |
| **PA-CF (Nylon Carbon)** | 80 – 100 | 260 – 290 | $\approx 1.2 - 1.8\%$ | Enclosed + Drybox! | Maximum tensile & structural rigidity |
| **TPU 95A** | 30 – 50 | 215 – 230 | Negligible | Open | High elasticity, damping, wear resistance |

## 4. Slicing Recommendations for Structural Parts
- **Wall Thickness**: Set outer perimeters to at least 4 walls ($1.6 - 2.0\text{ mm}$ for a 0.4 mm nozzle). Walls contribute $3\times$ more stiffness than infill percentage!
- **Infill Pattern**: Use **Gyroid** (isotropic strength across X/Y/Z) or **Cubic**. Avoid rectilinear grid for dynamic loads.
- **Orientation vs Stress**: Never orient tensile load perpendicular to layer lines ($Z$-axis); orient load vectors parallel to the bed ($X/Y$ planes).
