# xc7a50t_microblaze_FDAF
  Implement the adaptive filter through frequency domain method on Xilinx XC7A50T FPGA.
  
  Applied AD8861 and DAC8811 to convert signal data between analog and digital.
  
  Relized the whole adaptive filter process on soft core MicroBlaze (put the code at directory xc7a50t_AF.sdk/AF/src).
  
  Because of the performance limitation of MicroBlaze, achieved calculation acceleration by utilizing the Xilinx FFT IP and DMA IP to do heavy-load calculation on FPGA logic instead of MCU.

# Recreate Vivado Project
  Run the "RecreateProject.tcl" file at vivado will recreate the whole vivado project.
