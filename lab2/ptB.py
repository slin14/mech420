import numpy as np
import matplotlib.pyplot as plt

N = 360
Nq = N * 4
clock_freq = 1 / 0.0000025
for mv in [500, 750, 1000]:
    data = np.loadtxt(f'dat/Amot{mv}mV.csv', delimiter=',', skiprows=1)
    time = data[:, 0]
    chA = data[:, 1]
    chB = data[:, 2]
    diffA = np.abs(chA[1:] - chA[:-1])
    diffB = np.abs(chB[1:] - chB[:-1])
    dif = (diffA + diffB).astype(bool)
    tdif = time[1:]

    transitions = tdif[dif]

    pulses = len(transitions)
    total_time = time[-1] - time[0]
    pulse_count_v = 2 * np.pi * pulses / (Nq * total_time)
    pulse_count_res = 2 * np.pi  / (Nq * total_time)

    pulse_diff = transitions[1:] - transitions[:-1]
    pulse_time_v = 2 * np.pi / (Nq * pulse_diff)
    m = clock_freq * pulse_diff
    pulse_time_res = 2 * np.pi * clock_freq / (Nq * m * (m+1))

    pulse_tdif = transitions[1:]
    # plt.plot(pulse_tdif, pulse_time_v)
    # plt.show()

    pulse_time_v_avg = np.average(pulse_time_v)
    pulse_time_res_avg = np.average(pulse_time_res)
    pulse_time_res_approx = Nq * pulse_time_v_avg ** 2 / (2 * np.pi * clock_freq)

    print(f"voltage {mv}mV - pulse count {pulse_count_v} rad/s, resolution {pulse_count_res}; pulse timing {pulse_time_v_avg} rad/s, resolution {pulse_time_res_avg}, approx_res {pulse_time_res_approx}, time {total_time}")




