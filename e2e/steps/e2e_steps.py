from behave import given, when, then
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
import os
import time

CHROMEDRIVER_PATH = os.path.join(os.getcwd(), "chromedriver.exe")

@given("użytkownik otworzył stronę główną")
def step_open_home(context):    
    service = ChromeService(executable_path=CHROMEDRIVER_PATH)
    context.driver = webdriver.Chrome(service=service)
    context.driver.get("http://localhost:4200")
    time.sleep(2)

@when("użytkownik sprawdza listę walut")
def step_expand_currency(context):    
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "currency-select"))
    )    
    select_elem.click()    
    options = WebDriverWait(context.driver, 10).until(
        EC.presence_of_all_elements_located((By.TAG_NAME, "option"))
    )    
    assert len(options) > 1, "Lista walut nie zawiera więcej niż jednej opcji"

@when('użytkownik klika przycisk "{button_id}"')
def step_click_button(context, button_id):   
    button = WebDriverWait(context.driver, 10).until(
        EC.element_to_be_clickable((By.ID, button_id))
    )
    button.click()    
    time.sleep(2)

@when('użytkownik wybiera kurs "{kurs}"')
def step_select_rate(context, kurs):
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "table-select"))
    )
    select = Select(select_elem)
    select.select_by_value(kurs)
    
@when('użytkownik wybiera walutę "{currency}"')
def step_select_currency(context, currency):
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "currency-select"))
    )
    select = Select(select_elem)
    select.select_by_value(currency)

@when('użytkownik wybiera datę "{date_value}"')
def step_select_date(context, date_value):
    date_input = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "date-input"))
    )
    date_input.clear()
    date_input.send_keys(date_value)

@when('użytkownik wybiera rok "{year}"')
def step_select_year(context, year):
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "year-select"))
    )
    select = Select(select_elem)
    select.select_by_value(year)

@when('użytkownik wybiera kwartał "{quarter}"')
def step_select_quarter(context, quarter):
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "quarter-select"))
    )
    select = Select(select_elem)
    select.select_by_value(quarter)

@when('użytkownik wybiera miesiąc "{month}"')
def step_select_month(context, month):
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "month-select"))
    )
    select = Select(select_elem) 
    select.select_by_value(month)

@then("widoczna jest lista walut")
def step_check_currency_list(context):
    select_elem = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.ID, "currency-select"))
    )
    options = select_elem.find_elements(By.TAG_NAME, "option")
    assert len(options) > 1, "Lista walut nie zawiera dodatkowych opcji"
    context.driver.quit()

@then("widoczna jest tabela z kursami walut")
def step_check_table(context):
    table = WebDriverWait(context.driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, ".result table"))
    )
    assert table.is_displayed(), "Tabela wyników nie jest widoczna"    

    header = table.find_element(By.TAG_NAME, "thead")
    assert header is not None, "Brak nagłówka tabeli"
    
    body = table.find_element(By.TAG_NAME, "tbody")
    rows = body.find_elements(By.TAG_NAME, "tr")
    assert len(rows) > 0, "Tabela nie zawiera danych"
    context.driver.quit()