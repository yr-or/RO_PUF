import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

linux_path = "/user/masters/KilbyR/Project/RO_PUF_Linux/Outputs/"
win_path = "C:\\Users\\Rory\\Documents\\HDL\\RO_PUF\\Outputs\\"

file1 = "iladata4.csv"
file2 = "iladata_feedbackRO.csv"
file3 = "iladata_lfsr.csv"
file4 = "iladata_RO4_puf.csv"

file = linux_path + file4

df = pd.read_csv(file, skiprows=1)

df.info()

# Set start and end range
rand_nums = df["UNSIGNED.2"] #[1:].reset_index(drop=True)

# Remove every 7 of 8 values
#for i in range(len(rand_nums)):
#    if i % 8 != 0:
#        rand_nums = rand_nums.drop(i)
rand_nums = rand_nums.reset_index(drop=True)

bins = [i for i in range(0,256,16)]
bins.append(255)

plt.figure(figsize=(10,6))
plt.hist(rand_nums, bins=bins, color='tab:blue', edgecolor='black')
plt.xticks(bins)
plt.title("Random Number distribution")
plt.xlabel("Values")
plt.ylabel("No. values")
plt.show()

print(rand_nums.max())
print(rand_nums.min())

yunbiased = rand_nums-np.mean(rand_nums)
ynorm = np.sum(yunbiased**2)
acor = np.correlate(yunbiased, yunbiased, "same")/ynorm

plt.plot(acor)
plt.show()