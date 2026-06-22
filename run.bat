@echo off

echo =============================
echo MMU Simulation Starting
echo =============================

if not exist build mkdir build

iverilog -g2012 -o build/mmu_sim ^
tb/mmu_tb.v ^
tb/mem_bram.v ^
rtl/tlb.v ^
rtl/perm.v ^
rtl/ptw.v ^
rtl/mmu.v

if errorlevel 1 (
echo Compilation Failed
pause
exit
)

echo Compilation Successful

vvp build/mmu_sim

if errorlevel 1 (
echo Simulation Failed
pause
exit
)

echo Simulation Complete

gtkwave mmu.vcd

pause