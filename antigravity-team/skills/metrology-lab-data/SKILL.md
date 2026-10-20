---
name: metrology-lab-data
description: Automated processing of university laboratory experimental measurements according to ГОСТ 8.207. Calculates statistical direct errors (mean, variance, Student's t-test, confidence intervals), propagates indirect errors symbolically, and performs least-squares regression (МНК) with publication-quality plots.
---

# University Laboratory Metrology & Error Processing Skill

Use this skill when processing experimental data for engineering laboratory reports, calculating direct and indirect measurement errors, and fitting regression lines according to **ГОСТ 8.207**.

## 1. Mathematical Formulas (ГОСТ 8.207)

### A. Direct Measurements
Given a series of $n$ independent observations $x_1, x_2, \dots, x_n$:
1. **Sample Mean**:
   $$\bar{x} = \frac{1}{n} \sum_{i=1}^n x_i$$
2. **Sample Standard Deviation of the Mean ($S_{\bar{x}}$)**:
   $$S_{\bar{x}} = \sqrt{\frac{1}{n(n-1)} \sum_{i=1}^n (x_i - \bar{x})^2}$$
3. **Random Error ($\Delta x_{rand}$)**:
   $$\Delta x_{rand} = t_{\alpha, n} \cdot S_{\bar{x}}$$
   Where $t_{\alpha, n}$ is Student's coefficient for confidence probability $\alpha = 0.95$ and degrees of freedom $f = n - 1$.
4. **Total Absolute Error ($\Delta x$)**:
   $$\Delta x = \sqrt{\Delta x_{rand}^2 + \Delta x_{inst}^2}$$
   Where $\Delta x_{inst}$ is the instrument limit of error (цена деления / класс точности прибора).
5. **Relative Error ($\varepsilon$)**:
   $$\varepsilon = \frac{\Delta x}{\bar{x}} \times 100\%$$
6. **Final Result Representation**:
   $$x = (\bar{x} \pm \Delta x) \quad [\text{ед. изм.}], \quad P = 0.95$$

### B. Indirect Error Propagation
For an indirect quantity $y = f(x_1, x_2, \dots, x_m)$:
$$\Delta y = \sqrt{\sum_{k=1}^m \left(\frac{\partial f}{\partial x_k} \Delta x_k\right)^2}$$

---

## 2. Python Automated Calculation Engine

```python
import numpy as np
import scipy.stats as stats
import sympy as sp

def process_direct_measurements(values, inst_error, confidence=0.95):
    """
    Computes mean, random error, total error according to ГОСТ 8.207.
    """
    arr = np.array(values, dtype=float)
    n = len(arr)
    mean_val = np.mean(arr)
    
    if n > 1:
        s_mean = stats.sem(arr)  # std / sqrt(n)
        t_coeff = stats.t.ppf((1 + confidence) / 2.0, df=n-1)
        rand_error = t_coeff * s_mean
    else:
        rand_error = 0.0
        
    tot_error = np.sqrt(rand_error**2 + inst_error**2)
    rel_error_pct = (tot_error / abs(mean_val)) * 100.0 if mean_val != 0 else 0.0
    
    return {
        "n": n,
        "mean": mean_val,
        "rand_error": rand_error,
        "inst_error": inst_error,
        "total_error": tot_error,
        "rel_error_pct": rel_error_pct,
        "formatted": f"({mean_val:.4g} ± {tot_error:.2g})"
    }

def linear_regression_ols(x_data, y_data):
    """
    Calculates slope (a), intercept (b), and correlation coefficient (R2).
    Model: y = a*x + b
    """
    x = np.array(x_data, dtype=float)
    y = np.array(y_data, dtype=float)
    res = stats.linregress(x, y)
    
    return {
        "slope_a": res.slope,
        "intercept_b": res.intercept,
        "r_squared": res.rvalue**2,
        "slope_stderr": res.stderr,
        "formula": f"y = ({res.slope:.4g} ± {res.stderr:.2g})*x + {res.intercept:.4g}"
    }
```

## 3. Formatting Output for Typst (`@preview/modern-g7-32:0.2.0`)
When generating the report, format tables in Typst syntax:
```typst
#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center,
    [№ опыта], [Измеренное $x_i$, В], [Отклонение $Delta x_i$, В], [$(Delta x_i)^2$, В$^2$],
    [1], [10.2], [-0.1], [0.01],
    [2], [10.4], [+0.1], [0.01],
  ),
  caption: [Результаты прямых измерений напряжения],
)
```
