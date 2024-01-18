# This script saves and prints the channels data from log file in console in the format according "run_extractor.m". Just copy it from console into "run_extractor.m", also change path to .txt file to yours

import pandas as pd

# Read the CSV file
df = pd.read_csv("D:\Code\ReadMind\Column_extactor_ch_data\OpenBCI-RAW-2024-01-16_12-51-53.txt", skiprows=4)

# Iterate through all the channels
# List of channel names
channel_names = [
    "fp1_eeg_signal", "fp2_eeg_signal", "c3_eeg_signal", "c4_eeg_signal",
    "p7_eeg_signal", "p8_eeg_signal", "o1_eeg_signal", "o2_eeg_signal",
    "f3_eeg_signal", "f4_eeg_signal", "f7_eeg_signal", "f8_eeg_signal",
    "t7_eeg_signal", "t8_eeg_signal", "p3_eeg_signal", "p4_eeg_signal"
]

# Iterate through all the channels
for channel_index in range(1, 17):  # Exclude sampling rate (channel 0)
    # Extract the data from the current channel
    channel_data = df[df.columns[channel_index]]

    # Join the values with commas
    data_string = ','.join(channel_data.astype(str))

    # Save the channel data to a text file
    file_name = f"channel_{channel_index}.txt"
    with open(file_name, "w") as file:
        file.write(data_string)

    # Print the saved data in the requested format
    print(f"{channel_names[channel_index - 1]} = [{data_string}];")
