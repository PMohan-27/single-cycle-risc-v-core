# Run the test
TARGET=${1:-CPU_TOP}
echo "$TARGET"

make -B $TARGET

# Open waveform
cd sim_build/rtl

gtkwave $TARGET.fst

cd ../..