import json
import os
import random
import datetime

INPUT_FILE_NAME='/bachelorarbeit/pb_data.json'
OUTPUT_FILE_NAME='/bachelorarbeit/pb_data.log'

def main(input_file=INPUT_FILE_NAME, output_file=OUTPUT_FILE_NAME):
    with open(output_file, 'w') as ofile:
        with open(input_file, 'r') as ifile:
            for line in ifile:
                data = json.loads(line)
                ofile.write(data['message'] + os.linesep)

if __name__ == '__main__':
    main()
