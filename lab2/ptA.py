from matplotlib.transforms import Bbox
import numpy as np
import matplotlib.pyplot as plt
import sys

def printLatexTableRow(arr, file=None, precision=2):
    if file == None:
        file = sys.stdout

    for val in arr[:-1]:
        if arr.dtype == float:
            file.write(f"{val:.{precision}} & ")
        else:
            file.write(f"{val} & ")
    if arr.dtype == float:
        file.write(f"{arr[-1]:.{precision}} \\\\\n")
    else:
        file.write(f"{arr[-1]} \\\\\n")


positions = np.arange(11) * 5 # mm
print(positions)
voltages = np.empty_like(positions, dtype=float)
voltages_std = np.empty_like(positions, dtype=float)

for i, pos in enumerate(positions):
    filename = f"data/ptA/A_{pos}.csv"
    csv_data = np.loadtxt(filename, delimiter=',', skiprows=1)
    values = csv_data[:, 1]
    voltages[i] = np.average(values)
    voltages_std[i] = np.std(values)

print("Position, voltage avg, std dev[mV] rows:")
# printLatexTableRow(positions)
# printLatexTableRow(voltages)
# printLatexTableRow(voltages_std)
for pos, volt, vstd in zip(positions, voltages, voltages_std):
    print(f"{pos} & {volt:.3} & {vstd * 1000:.3} \\\\")

fig, axes = plt.subplots()
axes.plot(positions, voltages, label='Measured values', marker='o')
axes.grid()
axes.set_xlabel("Position, mm")
axes.set_ylabel("Voltage, V")

print("\n\n")

# Endpoint calibration curve
sensitivity = (voltages[-1] - voltages[0]) / (positions[-1] - positions[0])   # V/mm
zero_offset = voltages[0]

def calibration_curve(positions):
    return sensitivity * positions + zero_offset

linear_voltages = calibration_curve(positions)
axes.plot(positions, linear_voltages, label='End-points linear calibration curve')
print(f"Sensitivity [V/mm]: {sensitivity}")
print(f"Zero offset [V]: {zero_offset}")
axes.legend()

fig.set_size_inches([5, 3])
fig.savefig('img/calibration.png', bbox_inches='tight')
plt.close(fig)

calibration_error = linear_voltages - voltages
fig, axes = plt.subplots()
print(f"\nMax calibration err: {max(np.abs(calibration_error))}")
print(f"\nMax calibration err at : {positions[np.argmin(calibration_error)]}")
axes.plot(positions, calibration_error, marker='o')
axes.grid()
axes.set_xlabel("Position, mm")
axes.set_ylabel("Voltage nonlinearity error, V")
fig.set_size_inches([5, 3])
fig.savefig('img/nonlinearity.png', bbox_inches='tight')
# plt.show()

max_nonlin_error = max(np.abs(calibration_error))
max_position_nonlin_err = max_nonlin_error / sensitivity
print(f"Position nonlinearity error: {max_position_nonlin_err}")


