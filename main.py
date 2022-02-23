import json
import sys
from datetime import datetime

# membuka file


def get_file(inputfile):
    with open(inputfile) as file:
        return file.readlines()


def get_runtime_error(runtime_error_file):
    with open(runtime_error_file) as file:
        return file.read()

# mencari test, result, dan message


def find_test_result_error_message(result_list):
    test_list = []
    test_result = []

    test_error = []
    error_message = []
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
                    error_message.append(item)
                elif 'error' in item:
                    test_error.append(item)
            elif 'success' in item:
                overall_result = item

    return test_list, test_result, test_error, error_message, overall_result


def find_error_by_testid(test_error, error_message, id):
    message = ''
    for item in test_error:
        if item['testID'] == id:
            if item['error'].startswith('Test failed. See exception logs above.'):
                message = find_message_by_id(
                    error_message, id)['message']
                message = extract_message(message)
            elif item['error'].startswith('Failed to load'):
                message = "Error ketika membangun atau menjalankan program. \nTolong cek apakah anda mengirim file yang benar atau terdapat error sintaksis. \nRuntime Error yang ditampilkan dibawah mungkin dapat membantu."
    return message


def make_summary_test_list(test_list, result_list, test_error, message_list):
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
            summary['message'] = find_error_by_testid(
                test_error, message_list, id)
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

    message = 'expected: ' + expected + ',\nactual: ' + actual + ',\nwhich: ' + which
    return message


def make_summary(username, repo_name, pipeline_id, test_summary, runtime_error, overall_result):
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
    test['runtime_error'] = runtime_error

    summary['test'] = test

    return summary


def main(argv):

    inputfile = ''
    username = ''
    project_name = ''
    pipeline_id = ''

    args = sys.argv
    inputfile = args[1]
    runtimeErrorFile = args[2]
    username = args[3]
    project_name = args[4]
    pipeline_id = args[5]

    # mengambil file
    file_text = get_file(inputfile)
    # baca runtime_error
    runtime_error = get_runtime_error(runtimeErrorFile)
    # mengambil data untuk test dan deskripsinya
    test, result, error, message, overall_result = find_test_result_error_message(
        file_text)
    # membuat rangkuman terhadap test
    test_summary = make_summary_test_list(test, result, error, message)
    # membuat summary yang siap kirim
    summary = make_summary(username, project_name,
                           pipeline_id, test_summary, runtime_error,  overall_result)

    print(json.dumps(summary))


if __name__ == "__main__":
    main(sys.argv[1:])
