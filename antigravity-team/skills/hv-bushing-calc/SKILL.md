---
name: hv-bushing-calc
description: Electrophysical, dielectric, and thermal calculations for high-voltage bushings (RIP, RIN, OIP, GIS). Includes automated COMSOL Multiphysics modeling via MPh, 2D axisymmetric electrostatic simulation via pyfemm, capacitive foil grading design, and dielectric power loss calculations according to ГОСТ 10693 / IEC 60137.
---

# High-Voltage Bushing Calculation & Simulation Skill

Use this skill when designing, calculating, or modeling high-voltage condenser bushings (вводы конденсаторного типа), stress relief shields, and dielectric insulation in **COMSOL Multiphysics** and analytical workflows.

---

## 1. Governing Theoretical Formulas

### A. Condenser Foil Radius Distribution (Equal Capacitance / Constant Radial Stress)
For a bushing with $n$ capacitive layers between conductor radius $r_0$ and grounded flange radius $r_n$:
- **Condition for Equal Capacitances ($C_1 = C_2 = \dots = C_n$)**:
  $$C_k = \frac{2\pi \varepsilon_0 \varepsilon_r l_k}{\ln(r_k / r_{k-1})}$$
- **Condition for Constant Radial Electric Field ($E_{r,\max} = \text{const}$)**:
  $$r_k = r_0 \cdot \exp\left(k \cdot \frac{\ln(r_n / r_0)}{n}\right)$$
  $$l_k = l_1 \cdot \frac{r_0}{r_{k-1}}$$
  Where $l_k$ is the axial length of the $k$-th conductive foil.

### B. Dielectric Power Loss & Dissipation Factor ($\tan \delta$)
Active dielectric losses generated inside the insulation volume:
$$P_d = U^2 \cdot \omega \cdot C \cdot \tan \delta$$
Where:
- $U$ is the operating phase-to-ground RMS voltage ($\text{V}$).
- $\omega = 2\pi f = 100\pi \approx 314.16\text{ rad/s}$ for $50\text{ Hz}$.
- $C$ is the total bushing capacitance ($\text{F}$).
- $\tan \delta$ is the dielectric loss tangent (typically $<0.005$ for RIP/RIN, $<0.007$ for OIP at $20^\circ\text{C}$).

### C. Conductor Joule Heating
$$P_j = I_{rms}^2 \cdot R_{ac}(T)$$
$$R_{ac}(T) = R_{dc,20} \cdot [1 + \alpha_{Cu/Al}(T - 20)] \cdot k_{skin}$$

---

## 2. COMSOL Multiphysics Automation (`MPh`)

When working with COMSOL Multiphysics (.mph models), use the Python **`MPh`** library (`pip install MPh`). It interfaces with the COMSOL API via JPype without launching the heavy GUI.

### Headless COMSOL Script Example:
```python
import mph

def run_comsol_bushing_sweep(model_path: str, voltage_kv: float, foil_count: int):
    """
    Automates COMSOL Multiphysics simulation of an HV condenser bushing.
    Evaluates max electric field, capacitance, and dielectric heat dissipation.
    """
    # 1. Start headless COMSOL backend
    client = mph.start(cores=4)
    model = client.load(model_path)
    
    # 2. Set parametric variables in the COMSOL model
    model.parameter('U_phase', f'{voltage_kv} [kV]')
    model.parameter('N_foils', f'{foil_count}')
    model.parameter('eps_rip', '3.6')
    model.parameter('tan_delta', '0.004')
    
    # 3. Solve Multiphysics study (Electrostatics 'es' + Heat Transfer 'ht')
    model.solve('Study 1')
    
    # 4. Extract numerical metrics without opening GUI
    max_e_field = model.evaluate('es.maxE', 'kV/mm')
    capacitance_pf = model.evaluate('2 * es.intWe / (U_phase)^2', 'pF')
    p_dielectric_w = model.evaluate('intop_rip(es.Qh)', 'W')
    max_temp_c = model.evaluate('maxop_core(T) - 273.15', 'degC')
    
    print(f"--- COMSOL Bushing Results ({voltage_kv} kV) ---")
    print(f"Max Electric Field: {max_e_field:.3f} kV/mm")
    print(f"Bushing Capacitance C1: {capacitance_pf:.2f} pF")
    print(f"Dielectric Loss P_d: {p_dielectric_w:.2f} W")
    print(f"Hotspot Temperature: {max_temp_c:.1f} °C")
    
    # 5. Export field plot image headlessly
    model.export('Field_Distribution', 'bushing_efield.png')
    model.save('bushing_solved.mph')

if __name__ == '__main__':
    run_comsol_bushing_sweep('bushing_110kv.mph', 110.0 / 1.732, 24)
```

---

## 3. Lightweight 2D Simulation Fallback (`pyfemm`)

For rapid preliminary estimations without a COMSOL license, use `pyfemm` with axisymmetric cylindrical coordinates (`r, z`):

```python
import femm
import numpy as np

def simulate_femm_quick(r_core=25.0, r_flange=70.0, length_core=600.0, voltage_rms_kv=110.0, eps_r=3.6):
    v_peak = voltage_rms_kv * np.sqrt(2) / np.sqrt(3) * 1000.0
    femm.openfemm(1)
    femm.newdocument(3)
    femm.mi_probdef(0, 'mm', 'axisymmetric', 1e-8, 30, 30)
    # Define materials and geometry as documented in handbook...
    femm.mi_analyze(1)
    femm.mi_loadsolution()
```
