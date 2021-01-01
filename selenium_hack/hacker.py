from selenium import webdriver  
from webdriver_manager.chrome import ChromeDriverManager

driver = webdriver.Chrome(ChromeDriverManager().install())
l = []
for i in range(0, 10):
    for j in range(0, 10):        
        for k in range(0, 10):
            l.append((i, j, k))

print(len(l))

for i in range(0, len(l)):
    c1_length = l[i][0]
    c2_length = l[i][1]    
    c3_length = l[i][2]
    print(c1_length, c2_length, c3_length)
    driver.execute_script("window.open('https://qcvault.herokuapp.com');")
    c1 = driver.find_elements_by_xpath("/html/body/div[2]/canvas[1]")
    c2 = driver.find_elements_by_xpath("/html/body/div[2]/canvas[2]")
    c3 = driver.find_elements_by_xpath("/html/body/div[2]/canvas[3]")
    
    while c1_length > 0:
        c1.click()
        c1_length = c1_length - 1

    while c2_length > 0:
        c2.click()
        c2_length = c2_length - 1

    while c3_length > 0:
        c3.click()
        c3_length = c3_length - 1

    # button = driver.find_element_by_xpath("/html/body/div[3]/input")    
    # button.click()