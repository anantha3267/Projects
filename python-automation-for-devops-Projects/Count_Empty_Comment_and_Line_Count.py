import sys 

def count_lines(file_path):
    try:
        with open(file_path,"r") as file:
            line_count = 0
            comment_count = 0
            empty_count = 0
            for line in file:
                line_count += 1
                if line.strip()=="":
                    empty_count += 1
                if line.strip().startswith("#"):
                    comment_count += 1
        print(f"The file '{file_path}' contains {line_count} lines.")
        print(f"Empty lines: {empty_lines}")
        print(f"Comment lines: {comment_lines}")

        MAX_EMPTY_LINES = 2
        MAX_COMMENT_LINES = 5

        if empty_count > MAX_EMPTY_LINES:
            raise ValueError(f"too many empty lines: {empty_count} (max allowed: {MAX_EMPTY_LINES})")
        if comment_count > MAX_COMMENT_LINES:
            raise ValueError(f"Too many comment lines: {comment_count} (max allowed: {MAX_COMMENT_LINES})")
        return line_count, empty_count, comment_count
    
    except FileNotFoundError:
        print(f"File '{file_path}' not found.")
        return -1, -1, -1


if __name__ == "__main__":
    if len(sys.argv)!=2:
        print("python Count_Empty_Comment_and_Line_Count.py <filename>")
    else:
        file_path = sys.argv[1]
        line_count, empty_lines, comment_lines = count_lines(file_path)

        if line_count == -1:
            print("File processing failed.")