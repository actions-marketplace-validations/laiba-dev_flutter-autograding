import json

def get_file():
    with open('./examples/test-fail-example.txt') as file:
        return file.readlines()

def get_test(result_list):
    listTest = []
    for row in result_list:
        if(row.startswith('{"test":{')):
            listTest.append(json.loads(row))
    return listTest
    
    
def main():
    result_list = get_file() 
    print(get_test(result_list))


main()