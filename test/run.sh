# Run the test
make -B

# Open waveform
cd sim_build/rtl

gtkwave cpu_top.fst

cd ../..