import os
import pandas as pd 
  
for filename in os.listdir("data/xlsx"):
    read_file = pd.read_excel(f"data/xlsx/{filename}", skiprows=[0]) 
      
    read_file.to_csv(f"data/{filename.removesuffix('.xlsx')}.csv", index=None, header=True) 
