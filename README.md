# 💾 Memory Management Unit (MMU) Design using Verilog HDL

An advanced Memory Management Unit (MMU) implementation using Verilog HDL with frontend dashboard integration, TLB simulation, address translation, permission checking, and waveform analysis.

---

## 🚀 Project Overview

This project implements a Memory Management Unit (MMU) architecture that performs:

- Virtual Address → Physical Address translation
- Translation Lookaside Buffer (TLB)
- Permission checking
- Address mapping
- Simulation and waveform generation
- Interactive frontend dashboard
- Backend simulation control
- Translation history and statistics

---

## 📁 Project Structure

```text
MMU-Design-Verilog-HDL/

│
├── rtl/
│   ├── mmu.v
│   ├── tlb.v
│   ├── ptw.v
│   └── perm.v
│
├── tb/
│   ├── mmu_tb.v
│   └── mem_bram.v
│
├── backend/
│   ├── __init__.py
│   └── mmu_backend.py
│
├── interface/
│   └── dashboard.py
│
├── build/
│
├── simulation/
│
├── waveforms/
│
├── README.md
│
└── .gitignore
```

---

## ✨ Features

### MMU Features

✔ Virtual to Physical Address Translation

✔ Translation Lookaside Buffer (TLB)

✔ Permission checking

✔ Memory mapping

✔ Fault detection

✔ Translation simulation

---

### Dashboard Features

✔ Interactive dashboard

✔ Run MMU simulation button

✔ Translation history

✔ TLB hit/miss statistics

✔ Physical address display

✔ Performance metrics

✔ Simulation output viewer

✔ Graph visualization

---

## 🛠 Required Installation

### Install Python packages

```bash
pip install streamlit
pip install pandas
pip install plotly
```

### Install Verilog tools

Icarus Verilog

GTKWave

Check installation:

```bash
iverilog -V
vvp -V
gtkwave -V
```

---

## ▶ Running Frontend Dashboard

Move to project directory:

```bash
cd MMU-Design-Verilog-HDL
```

Run dashboard:

```bash
streamlit run interface/dashboard.py
```

Open browser:

```text
http://localhost:8501
```

---

## ▶ Running Verilog Simulation

Compile:

```bash
iverilog -g2012 -o build/mmu_sim \
tb/mmu_tb.v \
tb/mem_bram.v \
rtl/tlb.v \
rtl/perm.v \
rtl/ptw.v \
rtl/mmu.v
```

Run simulation:

```bash
vvp build/mmu_sim
```

---

## 📊 Open Waveforms

Open GTKWave:

```bash
gtkwave mmu.vcd
```

Recommended signals:

```text
clk
req_valid
req_va
rsp_valid
rsp_pa
rsp_fault
rsp_xfault
mem_req
mem_addr
```

---

## 🔄 MMU Workflow

```text
Virtual Address
        ↓
VPN Extraction
        ↓
TLB Lookup
        ↓
TLB Hit/Miss
        ↓
Permission Check
        ↓
Physical Address Translation
        ↓
Fault Detection
```

---
## Screenshots
<img width="1366" height="768" alt="Screenshot 2026-06-22 134916" src="https://github.com/user-attachments/assets/4c08bea4-a81c-4b44-a386-e90b53aab0a2" />
<img width="1366" height="768" alt="Screenshot 2026-06-22 134924" src="https://github.com/user-attachments/assets/3ed0f801-a91c-4d11-969d-feb17eab7741" />
<img width="1366" height="768" alt="Screenshot 2026-06-22 134427" src="https://github.com/user-attachments/assets/fdbbc8b1-4413-43a3-a169-5b6e6cf40f35" />

## 📷 Dashboard Preview

The dashboard displays:

- Simulation statistics
- Translation history
- Performance graphs
- TLB information
- Physical addresses
- Simulation output

---

## 🎯 Applications

- Operating Systems
- Computer Architecture
- FPGA Systems
- Processor Design
- VLSI Projects
- Educational Simulators

---

## 📈 Future Upgrades

- Real-time waveform integration
- Memory heatmap
- AI assistant integration
- Live FPGA monitoring
- Advanced TLB visualization
- Performance analytics

---


## 👩‍💻 Author

Tanisha Mittal

---

## ⭐ If you like this project

Star the repository and connect on LinkedIn.
