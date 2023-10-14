from matplotlib.transforms import Bbox
import numpy as np
import matplotlib.pyplot as plt
import sys

def plot_lin_spring(F, x, spring):
    fig, axes = plt.subplots()
    #axes.plot(x, F, label='Measured values', marker='o')
    axes.plot(x, F, label='Measured values')
    
    #line of best fit: y = ax
    x = x[:,np.newaxis] # change from 1D into 2D
    a, _, _, _ = np.linalg.lstsq(x, F)
    axes.plot(x, a*x, color='red', linestyle='--', label=f"F(x)={a[0]:.2}x")
    
    axes.grid()
    axes.set_xlabel("Position, mm")
    axes.set_ylabel("Force, N")
    axes.legend()
    fig.set_size_inches([5, 3])
    fig.savefig(f"img/A_{spring}.png", bbox_inches='tight')
    plt.close(fig)

def plot_pretensioned_spring(F, x, spring):
    fig, axes = plt.subplots()
    #axes.plot(x, F, label='Measured values', marker='o')
    axes.plot(x, F, label='Measured values')
    
    #line of best fit: y = ax + b
    a, b = np.polyfit(x, F, 1)
    axes.plot(x, a*x+b, color='red', linestyle='--', label=f"F(x) = {a:.2}x + {b:.2}")
    
    axes.grid()
    axes.set_xlabel("Position, mm")
    axes.set_ylabel("Force, N")
    axes.legend()
    fig.set_size_inches([5, 3])
    fig.savefig(f"img/A_{spring}.png", bbox_inches='tight')
    plt.close(fig)

lin_spring = [1, 2]

for spring in lin_spring:
    filename = f"data/A{spring}.csv"
    #filename = f"data/A{pos}.csv"
    csv_data = np.loadtxt(filename, delimiter=',', skiprows=1)
    load_cell = csv_data[:, 1] # kg
    lvdt      = csv_data[:, 2] # V
    load_cell = load_cell - load_cell[0] # zero load cell
    F = load_cell * 9.81 # N
    x = (lvdt + 0.072) / 0.193
    x = x - x[0] # zero position measured by LVDT
    plot_lin_spring(F, x, spring)

pre_spring = [3, 4]
for spring in pre_spring:
    filename = f"data/A{spring}.csv"
    #filename = f"data/A{pos}.csv"
    csv_data = np.loadtxt(filename, delimiter=',', skiprows=1)
    load_cell = csv_data[:, 1] # kg
    lvdt      = csv_data[:, 2] # V
    load_cell = load_cell - load_cell[0] # zero load cell
    F = load_cell * 9.81 # N
    x = (lvdt + 0.072) / 0.193
    x = x - x[0] # zero position measured by LVDT
    plot_pretensioned_spring(F, x, spring)
