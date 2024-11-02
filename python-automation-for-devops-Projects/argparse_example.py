import argparse

def main():
    parser = argparse.ArgumentParser(description="Process Some Integers")
    parser.add_argument('--name',type=str,default="John Doe",help="Name of the Person")
    parser.add_argument('--age', type=int, default=55, help='Age of the person')

    args=parser.parse_args()
    print(f"Hello, {args.name}! You are {args.age} years old.")

if __name__ == "__main__":
    main()