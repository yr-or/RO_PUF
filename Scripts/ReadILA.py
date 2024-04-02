import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv(r"C:\Users\Rory\Documents\HDL\RO_PUF\iladata3.csv")
df = df.drop(0).reset_index(drop=True)

rand_nums = df["rand_num[7:0]"]
rand_nums = rand_nums[6:].reset_index(drop=True)

for i in range(len(rand_nums)):
    if i % 8 != 0:
        rand_nums = rand_nums.drop(i)
        
rand_nums.info()

plt.hist(rand_nums, bins=20)
plt.show()