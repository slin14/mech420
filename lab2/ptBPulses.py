import pandas as pd
from numpy import mean, std

data = pd.read_csv('partb.csv')

pulses = []
start = 0
end = 0

for i in range(1, len(data)):
    if data['Channel A'][i] == 1 and data['Channel A'][i-1] == 0:
        start = i
    if data['Channel A'][i] == 0 and data['Channel A'][i-1] == 1:
        end = i - 1
        pulses.append(data["Position (mm)"][end] - data["Position (mm)"][start])

results = {"Average Pulse Width": mean(pulses), "Standard Deviation": std(pulses)}
print(pulses)
print(results)
