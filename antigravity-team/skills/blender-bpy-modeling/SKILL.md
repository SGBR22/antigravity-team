---
name: blender-bpy-modeling
description: Automates Blender operations and 3D modeling using headless Python scripting (bpy). Generates procedural geometry, applies modifiers, handles boolean operations, and exports to STL, OBJ, and GLTF.
---

# Blender Python Scripting Skill (`bpy`)

Use this skill when generating 3D models programmatically, running batch mesh modifications, or executing automated exports in Blender.

## 1. Headless Execution Protocol
Always run Blender scripts in the background (headless) to save GPU resources, avoid UI popups, and support CLI automation:

```powershell
blender --background --python script.py
# Or with CLI arguments passed after '--':
blender --background --python script.py -- --output model.stl --radius 15.0
```

## 2. Standard Script Template (Scene Cleanup + Geometry Generation)

```python
import bpy
import sys

def clean_scene():
    """Removes default cube, light, and camera."""
    bpy.ops.wm.read_factory_settings(use_empty=True)

def create_parametric_bushing_insulator(height=120.0, base_radius=30.0, shed_count=6, shed_radius=45.0):
    """
    Creates a high-voltage shed insulator profile procedurally.
    Dimensions in millimeters.
    """
    clean_scene()
    
    # 1. Create central core cylinder
    bpy.ops.mesh.primitive_cylinder_add(
        radius=base_radius,
        depth=height,
        vertices=64,
        location=(0, 0, height / 2.0)
    )
    core = bpy.context.active_object
    core.name = "Insulator_Core"

    # 2. Add sheds along Z
    shed_spacing = height / (shed_count + 1)
    for i in range(1, shed_count + 1):
        z_pos = i * shed_spacing
        bpy.ops.mesh.primitive_cone_add(
            radius1=shed_radius,
            radius2=base_radius,
            depth=10.0,
            vertices=64,
            location=(0, 0, z_pos)
        )
        shed = bpy.context.active_object
        shed.name = f"Shed_{i}"
        
        # Boolean union with core
        mod = core.modifiers.new(type="BOOLEAN", name=f"Union_Shed_{i}")
        mod.operation = 'UNION'
        mod.object = shed
        mod.solver = 'EXACT'
        
        bpy.context.view_layer.objects.active = core
        bpy.ops.object.modifier_apply(modifier=mod.name)
        bpy.data.objects.remove(shed, do_unlink=True)

    # 3. Apply remesh / smooth shading
    bpy.ops.object.shade_smooth()
    return core

def export_stl(filepath="output.stl"):
    bpy.ops.wm.stl_export(filepath=filepath)
    print(f"[Blender] Successfully exported: {filepath}")

if __name__ == "__main__":
    create_parametric_bushing_insulator()
    export_stl("bushing_insulator.stl")
```

## 3. Best Practices for 3D Printing Output
1. **Apply Scale & Transforms**: Always run `bpy.ops.object.transform_apply(location=True, rotation=True, scale=True)` before exporting to avoid distortion in slicers.
2. **Normals Orientation**: Recalculate normals to face outward:
   ```python
   bpy.ops.object.mode_set(mode='EDIT')
   bpy.ops.mesh.select_all(action='SELECT')
   bpy.ops.mesh.normals_make_consistent(inside=False)
   bpy.ops.object.mode_set(mode='OBJECT')
   ```
3. **Bevel Modifier**: For functional prints, avoid sharp $90^\circ$ internal corners to prevent stress concentration; add a slight procedural Bevel modifier.
