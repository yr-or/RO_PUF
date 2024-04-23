import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

file1 = r"C:\Users\Rory\Documents\HDL\RO_PUF\iladata4.csv"
file2 = r"C:\Users\Rory\Documents\HDL\RO_PUF\iladata_feedbackRO.csv"
file3 = r"C:\Users\Rory\Documents\HDL\RO_PUF\iladata_lfsr.csv"
file4 = r"C:\Users\Rory\Documents\HDL\RO_PUF\iladata_LFSR16.csv"

df = pd.read_csv(file3, skiprows=1)

df.info()

# Set start and end range
rand_nums = df["UNSIGNED.2"] #[1:].reset_index(drop=True)

# Remove every 7 of 8 values
#for i in range(len(rand_nums)):
#    if i % 8 != 0:
#        rand_nums = rand_nums.drop(i)
#rand_nums = rand_nums.reset_index(drop=True)

bins = [i for i in range(0,255,16)]
bins.append(256)

plt.figure(figsize=(10,6))
plt.hist(rand_nums, bins=bins, color='tab:blue', edgecolor='black')
plt.xticks(bins)
plt.title("Random Number distribution")
plt.xlabel("Values")
plt.ylabel("No. values")
plt.show()

print(rand_nums.max())
print(rand_nums.min())

plt.figure(2)
yunbiased = rand_nums-np.mean(rand_nums)
ynorm = np.sum(yunbiased**2)
acor = np.correlate(yunbiased, yunbiased, "same")/ynorm

plt.plot(acor)
plt.show()





