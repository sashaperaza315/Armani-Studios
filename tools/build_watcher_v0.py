"""
Hollowhunt - The Watcher, rough first-pass model builder (Blender script)

WHAT THIS IS
A rough, disposable first draft of The Watcher built entirely from Armani's
locked description in docs/design/ARMANI_CREATIVE_DECISIONS.md:
  "A giant human eye with two enormous human feet. No other limbs."
This is NOT final art. It exists so Armani has something in 3D to react to
("does this still feel like The Watcher?") before any real modeling time
goes in. Reject it, redo it, ignore it - that's the point of a rough draft.

HOW TO RUN IT (pick one)

Option A - Blender's Scripting tab (easiest, no Terminal needed):
  1. Open Blender (download free from blender.org if you don't have it).
  2. Click the "Scripting" tab along the top of the Blender window.
  3. Click "New" in the script editor, then paste this entire file's contents.
  4. Click the Play/Run button (or press Alt+P) in the script editor.
  5. Look at the 3D viewport - The Watcher should appear. Rotate around it
     with the middle mouse button.
  6. The .glb file is already saved automatically (see EXPORT_PATH below) -
     no extra export step needed.

Option B - Terminal, fully headless (no window pops up):
  cd "/Users/ceo/Armanis studio/hollowhunt-repo"
  blender --background --python tools/build_watcher_v0.py

WHAT HAPPENS NEXT
The exported file lands at project/assets/models/watcher_v0.glb. Nothing in
the actual game (project/scenes/creatures/watcher/watcher.tscn) has been
changed to use it yet - that's a deliberate pause point so Armani can see
and approve it first, per the studio's own rule that no creature ships
without his sign-off. Once approved, ask to have it wired into the scene.
"""

import bpy
import os

# ---------------------------------------------------------------------------
# Where the finished model gets saved. Change this if your folder is
# somewhere other than the default Cowork location.
# ---------------------------------------------------------------------------
EXPORT_PATH = "/Users/ceo/Armanis studio/hollowhunt-repo/project/assets/models/watcher_v0.glb"


def clear_scene():
    """Wipe the default Blender scene (default cube, camera, light) so we
    start from nothing every time this script runs."""
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for block in list(bpy.data.meshes):
        if block.users == 0:
            bpy.data.meshes.remove(block)


def set_bsdf_input(bsdf, candidate_names, value):
    """Principled BSDF input names changed slightly between Blender 3.x and
    4.x (e.g. 'Emission' vs 'Emission Color'). Try each candidate name so
    this script works on either version without editing."""
    for name in candidate_names:
        if name in bsdf.inputs:
            bsdf.inputs[name].default_value = value
            return


def make_material(name, color, roughness=0.7, emission_color=None, emission_strength=0.0):
    mat = bpy.data.materials.new(name=name)
    mat.use_nodes = True
    bsdf = mat.node_tree.nodes.get("Principled BSDF")
    set_bsdf_input(bsdf, ["Base Color"], (*color, 1.0))
    set_bsdf_input(bsdf, ["Roughness"], roughness)
    if emission_color:
        set_bsdf_input(bsdf, ["Emission Color", "Emission"], (*emission_color, 1.0))
        set_bsdf_input(bsdf, ["Emission Strength"], emission_strength)
    return mat


def add_eye():
    """The eye - a giant sclera sphere with a layered iris and pupil, smoothed
    with a Subdivision Surface modifier so it reads as an eyeball, not a
    faceted ball. Armani's Creative Decision #4: the scare is that it's
    JUST an eye and feet - keep this simple, not overdesigned."""
    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.6, location=(0, 0, 1.4), segments=32, ring_count=16)
    eye = bpy.context.active_object
    eye.name = "Watcher_Eye"
    bpy.ops.object.shade_smooth()
    mod = eye.modifiers.new(name="Smooth", type='SUBSURF')
    mod.levels = 1
    mod.render_levels = 2
    eye.data.materials.append(make_material("Eye_Sclera", (0.88, 0.86, 0.80), roughness=0.35))

    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.3, location=(0, -0.48, 1.4), segments=24, ring_count=12)
    iris = bpy.context.active_object
    iris.name = "Watcher_Iris"
    iris.scale = (1.0, 0.55, 1.0)
    bpy.ops.object.shade_smooth()
    iris.data.materials.append(make_material(
        "Eye_Iris", (0.32, 0.08, 0.07), roughness=0.4,
        emission_color=(0.55, 0.08, 0.06), emission_strength=1.2))

    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.13, location=(0, -0.62, 1.4), segments=16, ring_count=8)
    pupil = bpy.context.active_object
    pupil.name = "Watcher_Pupil"
    pupil.scale = (1.0, 0.5, 1.0)
    bpy.ops.object.shade_smooth()
    pupil.data.materials.append(make_material("Eye_Pupil", (0.02, 0.01, 0.01), roughness=0.2))


def add_foot(x_offset, name_prefix):
    """One bare human foot - a heel/arch block plus a rounded toe block,
    both beveled for a soft, organic (not boxy) silhouette. Two of these,
    mirrored left/right, are the ONLY other body part The Watcher has."""
    foot_mat = make_material(f"{name_prefix}_Skin", (0.78, 0.66, 0.58), roughness=0.6)

    bpy.ops.mesh.primitive_cube_add(size=1, location=(x_offset, 0.05, 0.18))
    heel = bpy.context.active_object
    heel.name = f"{name_prefix}_Heel"
    heel.scale = (0.16, 0.32, 0.16)
    bevel = heel.modifiers.new(name="Bevel", type='BEVEL')
    bevel.width = 0.04
    bevel.segments = 3
    bpy.ops.object.shade_smooth()
    heel.data.materials.append(foot_mat)

    bpy.ops.mesh.primitive_cube_add(size=1, location=(x_offset, -0.32, 0.14))
    toe = bpy.context.active_object
    toe.name = f"{name_prefix}_Toe"
    toe.scale = (0.13, 0.16, 0.12)
    bevel2 = toe.modifiers.new(name="Bevel", type='BEVEL')
    bevel2.width = 0.05
    bevel2.segments = 3
    bpy.ops.object.shade_smooth()
    toe.data.materials.append(foot_mat)


def main():
    clear_scene()
    add_eye()
    add_foot(-0.3, "LeftFoot")
    add_foot(0.3, "RightFoot")

    os.makedirs(os.path.dirname(EXPORT_PATH), exist_ok=True)
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.export_scene.gltf(
        filepath=EXPORT_PATH,
        export_format='GLB',
        use_selection=True,
        export_apply=True,
    )
    print(f"[Hollowhunt] The Watcher v0 exported to: {EXPORT_PATH}")


main()
