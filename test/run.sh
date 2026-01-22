# Run the test
TARGET=${1:-CPU_TOP}
make -B $TARGET

echo "$TARGET"
# Open waveform
cd sim_build/rtl

gtkwave $TARGET.fst

cd ../..