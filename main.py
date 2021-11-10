import json
import sys
from datetime import datetime

# membuka file
def get_file(inputfile):
    with open(inputfile) as file:
        return file.readlines()

# mencari test, result, dan message
def find_test_result_message(result_list):
    test_list = []
    test_result = []
    test_message = []
    overall_result = {}
    for row in result_list:
        if row.startswith('{'):
            item = json.loads(row)
            if('test' in item):
                test_list.append(item)
            elif('testID' in item):
                if 'result' in item:
                    test_result.append(item)
                elif 'message' in item:
                    test_message.append(item)
            elif 'success' in item:
                overall_result = item

    return test_list, test_result, test_message, overall_result

# menghapus test yang hanya loading scenario test


def remove_loading_test(test_list):
    filtered_test = []
    for test in test_list:
        test_name = test['test']['name']
        if (not test_name.startswith('loading')) & (not test_name.endswith('dart')):
            filtered_test.append(test)

    return filtered_test


def make_summary_test_list(test_list, result_list, message_list):
    tests = []
    for item in test_list:
        # membuat summary
        summary = {}
        id = item['test']['id']
        summary['id'] = id
        summary['name'] = item['test']['name']

        # mencari result
        result = find_result_by_id(result_list, id)
        summary['result'] = result['result']

        # mencari error message
        if result['result'] == 'error':
            message = find_message_by_id(message_list, id)['message']
            summary['message'] = extract_message(message)
        else:
            summary['message'] = None

        tests.append(summary)

    return tests


def find_message_by_id(message_list, id):
    result = {}
    for item in message_list:
        if item['testID'] == id:
            result = item

    return result


def find_result_by_id(result_list, id):
    result = {}
    for item in result_list:
        if item['testID'] == id:
            result = item

    return result


def extract_message(message):
    actual = ''
    expected = ''
    which = ''
    list_message_row = message.split('\n')
    for row in list_message_row:
        data = row.strip()
        if data.startswith('Actual:'): 
            actual = data.split(' ', 1)[1]
        elif data.startswith('Expected:'): 
            expected = data.split(' ', 1)[1]
        elif data.startswith('Which:'): 
            which = data.split(' ', 1)[1]

    print()
    return ''


def make_summary(username, repo_name, pipeline_id, test_summary, overall_result):
    summary = {}
    now = datetime.now()

    about = {
        'username': username,
        'project_name': repo_name,
        'time': now.strftime("%m/%d/%Y, %H:%M:%S")
    }

    summary['about'] = about

    test = {}

    test['pipeline_id'] = pipeline_id
    test['success'] = overall_result['success']
    test['tests'] = test_summary

    summary['test'] = test

    return summary


def main(argv):

    inputfile = ''
    username = ''
    project_name = ''
    pipeline_id = ''

    args = sys.argv
    inputfile = args[1]
    username = args[2]
    project_name = args[3]
    pipeline_id = args[4]

    # mengambil file
    file_text = get_file(inputfile)
    # mengambil data untuk test dan deskripsinya
    test, result, message, overall_result = find_test_result_message(file_text)
    # mennghapus test yang mengandung loading
    test = remove_loading_test(test)
    # membuat rangkuman terhadap test
    test_summary = make_summary_test_list(test, result, message)
    # membuat summary yang siap kirim
    summary = make_summary(username, project_name, pipeline_id, test_summary, overall_result)

    print(json.dumps(summary))


if __name__ == "__main__":
    main(sys.argv[1:])
