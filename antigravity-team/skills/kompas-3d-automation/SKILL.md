---
name: kompas-3d-automation
description: Automates KOMPAS-3D CAD workflows via Python pywin32. Covers API 5 and API 7 connection, 2D drawing stamp (штамп) population according to ГОСТ 2.104, 3D part modeling, and batch export to STEP/PDF.
---

# KOMPAS-3D Automation Skill (Python + pywin32)

Use this skill when automating KOMPAS-3D operations, creating 2D/3D models programmatically, reading or modifying drawing title blocks (штампы ЕСКД), or batch-converting files.

## 1. Prerequisites
- KOMPAS-3D installed on Windows (v18 – v23+).
- Python package: `pip install pywin32`.

## 2. Connecting to KOMPAS (API 5 & API 7)

```python
import pythoncom
from win32com.client import Dispatch, gencache

# --- API 7 (Modern Object Model: Documents, Sheets, Stamps) ---
def get_kompas_api7():
    try:
        app7 = Dispatch("Kompas.Application.7")
        app7.Visible = True
        return app7
    except Exception as e:
        print(f"Failed to connect to API 7: {e}")
        return None

# --- API 5 (Procedural & Low-Level Geometry) ---
API5_CLSID = '{0422828C-F174-495E-AC5D-D31014DBBE87}'
def get_kompas_api5():
    try:
        module = gencache.EnsureModule(API5_CLSID, 0, 1, 0)
        kompas5 = Dispatch("Kompas.Application.5", None, module.KompasObject.CLSID)
        kompas5.Visible = True
        return kompas5
    except Exception as e:
        print(f"Failed to connect to API 5: {e}")
        return None
```

## 3. Modifying 2D Drawing Title Block (Штамп по ГОСТ 2.104)

```python
def update_stamp_fields(doc_path=None, fields_dict=None):
    """
    Standard Stamp Cells (ГОСТ 2.104):
    Cell 1: Наименование детали/узла
    Cell 2: Обозначение чертежа (Децимальный номер, напр. АБВГ.XXXXXX.001)
    Cell 3: Материал детали
    Cell 4: Литера (напр. 'У' или 'О1')
    Cell 5: Масса (кг)
    Cell 6: Масштаб
    Cell 9: Наименование предприятия (напр. 'МГТУ им. Баумана' или 'Завод ВВ')
    Cell 11: Фамилия разработчика
    Cell 12: Фамилия проверяющего
    """
    app7 = Dispatch('Kompas.Application.7')
    doc = app7.ActiveDocument if not doc_path else app7.Documents.Open(doc_path, False, False)
    if not doc:
        return False

    doc2d = app7.IKompasDocument2D(doc)
    sheet = doc2d.LayoutSheets.Item(0)
    stamp = sheet.Stamp

    if fields_dict:
        for cell_idx, text_val in fields_dict.items():
            text_obj = stamp.Text(cell_idx)
            text_obj.Str = str(text_val)
        stamp.Update()
    
    doc.Save()
    return True
```

## 4. Batch Export to STEP & PDF

```python
def export_active_document(export_type="STEP"):
    app7 = Dispatch('Kompas.Application.7')
    doc = app7.ActiveDocument
    if not doc:
        print("No active document.")
        return

    src_path = doc.PathName
    if not src_path:
        print("Document not saved yet.")
        return

    base_path = src_path.rsplit('.', 1)[0]
    
    if export_type.upper() == "STEP":
        target_path = f"{base_path}.step"
        # Additional parameters can be set via ksAdditionalParameters7
        doc.SaveAs(target_path)
        print(f"Exported STEP: {target_path}")
    elif export_type.upper() == "PDF":
        target_path = f"{base_path}.pdf"
        doc.SaveAs(target_path)
        print(f"Exported PDF: {target_path}")
```

## 5. Troubleshooting & SDK Reference
- **Local Documentation**: `C:\Program Files\ASCON\KOMPAS-3D v<version>\SDK\SDK.chm` contains all interface IDs, enums, and method signatures.
- **Circuit Breaker Rule**: If dispatching fails twice, verify that KOMPAS is running or registered in COM (`regsvr32` or repair install).
