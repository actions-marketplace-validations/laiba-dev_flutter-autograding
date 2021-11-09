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

def remove_loading_test(test_list_with_description):
    result = []

    for item in test_list_with_description:
        if item['test']['name'].startswith('loading'):
            continue
        else:
            result.append(item)

    return result
    
    
def main():
    # mengambil file
    result_list = get_file() 
    #mengambil data untuk test dan deskripsinya
    test_list_with_description = get_test(result_list)
    # menghilangkan test yang hanya untuk loading file
    cleaned_test_list = remove_loading_test(test_list_with_description)

    print(cleaned_test_list)

main()