---
name: uncertainty-and-units
description: Tracks physical units and propagates measurement uncertainty in scientific and engineering calculations using pint and uncertainties. Follows GUM (Guide to the Expression of Uncertainty in Measurement) and ISO/IEC 17025.
---

# Physical Units & Measurement Uncertainty Skill (GUM + pint + uncertainties)

Use this skill whenever performing scientific calculations, validating physical dimensions, calculating laboratory measurement uncertainty budgets, or converting units.

## 1. Prerequisites & Libraries
- **`pint`**: Unit definition, dimensional analysis, automatic conversions.
- **`uncertainties`**: Full linear and non-linear error propagation with correlation handling.
```bash
pip install pint uncertainties
```

## 2. Dimensional Verification & Unit Conversion (`pint`)

```python
import pint

ureg = pint.UnitRegistry()
Q_ = ureg.Quantity

# 1. Define physical quantities with units
voltage = 110.0 * ureg.kilovolt
capacitance = 350.0 * ureg.picofarad
frequency = 50.0 * ureg.hertz
omega = 2 * 3.1415926535 * frequency
tan_delta = 0.004  # dimensionless

# 2. Compute Dielectric Loss Power: P = U^2 * omega * C * tan_delta
# Automatically verifies dimensional consistency: V^2 * (1/s) * F = Watts!
power_loss = (voltage**2 * omega * capacitance * tan_delta).to(ureg.watt)
print(f"Dielectric Power Loss: {power_loss:.3f}")
# Output: 53.219 watt

# 3. Dimensional consistency check
if not power_loss.check('[power]'):
    raise ValueError("Formula dimensional mismatch: expected power (W)!")
```

## 3. GUM Uncertainty Budget (`uncertainties`)

Follows **GUM (JCGM 100:2008)** and **ГОСТ 8.207**:
- **Type A Evaluation**: Based on statistical repetition (sample variance, standard error of the mean $S_{\bar{x}}$).
- **Type B Evaluation**: Based on instrument specs (класс точности, цена деления $\Delta x_{inst} = \delta_{inst} / \sqrt{3}$ for uniform distribution).
- **Expanded Uncertainty**: $U_e = k \cdot u_c$, where $k=2$ for $P = 95.45\%$.

```python
import numpy as np
from uncertainties import ufloat
from uncertainties.umath import sqrt, log, exp

def evaluate_bushing_stress_with_uncertainty():
    """
    Evaluates radial electric field with measurement uncertainty:
    E_r = U / (r * ln(R / r))
    """
    # Potential: 110 kV RMS phase-to-ground peak +/- 1.5% instrument error (k=2)
    u_peak_val = 110.0 * np.sqrt(2) / np.sqrt(3) * 1000.0  # Volts
    u_peak = ufloat(u_peak_val, u_peak_val * 0.015 / 2.0)
    
    # Radii measured with caliper: r = (25.0 +/- 0.1) mm, R = (70.0 +/- 0.2) mm
    r = ufloat(25.0, 0.1)
    R = ufloat(70.0, 0.2)
    
    # Peak electric field at conductor surface (V/mm)
    e_max = u_peak / (r * log(R / r))
    
    # Convert to kV/mm
    e_max_kv_mm = e_max / 1000.0
    
    print(f"Max Field: {e_max_kv_mm:.3f} kV/mm")
    print(f"  Nominal: {e_max_kv_mm.nominal_value:.3f} kV/mm")
    print(f"  Standard Uncertainty (u): {e_max_kv_mm.std_dev:.3f} kV/mm")
    print(f"  Expanded Uncertainty (k=2, 95%): {2 * e_max_kv_mm.std_dev:.3f} kV/mm")
    print(f"  Relative Uncertainty: {(e_max_kv_mm.std_dev / e_max_kv_mm.nominal_value) * 100:.2f}%")
    
    return e_max_kv_mm

if __name__ == '__main__':
    evaluate_bushing_stress_with_uncertainty()
```

## 4. Dimensionless Group Plausibility Audits
Always verify physical plausibility using dimensionless numbers before finalizing results:
- **Dielectric Loss Factor**: $\tan \delta \ll 1$ (for oil/paper/resin: $0.002 - 0.010$).
- **Reynolds Number ($Re$)**: Laminar ($< 2300$) vs Turbulent ($> 4000$) for transformer cooling channels.
- **Biot Number ($Bi$)**: $< 0.1$ indicates thermally lumped conductor rod; $> 0.1$ requires thermal gradient calculation across insulation layers.
