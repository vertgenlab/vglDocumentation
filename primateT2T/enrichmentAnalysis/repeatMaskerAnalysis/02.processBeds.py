import os
import pandas as pd


bed_files = [
    "human.RepeatMasker.bed",
    "gorilla.RepeatMasker.bed",
    "bonobo.RepeatMasker.bed",
    "chimpanzee.RepeatMasker.bed",
]

# pulls the Class (ex. LINE, SINE) out of the name field of the bed
def extract_class_label(name):
    name = name.replace('?', '_lowConfidence')
    return name.split('#')[1].split('/')[0]

def extract_family_label(name):
    name = name.replace('?', '_lowConfidence')
    try:
        return name.split('#')[1].split('/')[1]
    except IndexError:
        return name.split('#')[1].split('/')[0]

for bed_file_path in bed_files:
    bed_df = pd.read_csv(bed_file_path, sep='\t', header=None)
    bed_df[3] = bed_df[3].apply(extract_class_label)
    output_file_path = os.path.splitext(bed_file_path)[0] + 'Class.bed'
    bed_df.to_csv(output_file_path, sep='\t', header=False, index=False)

    bed_df = pd.read_csv(bed_file_path, sep="\t", header=None)
    bed_df[3] = bed_df[3].apply(extract_family_label)
    output_file_path = os.path.splitext(bed_file_path)[0] + 'Family.bed'
    bed_df.to_csv(output_file_path, sep='\t', header=False, index=False)
