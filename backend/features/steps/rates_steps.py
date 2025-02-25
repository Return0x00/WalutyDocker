from behave import given, when, then
from fastapi.testclient import TestClient
from main import app  # Upewnij się, że main.py znajduje się w katalogu backend

client = TestClient(app)

@given("API jest uruchomione")
def step_api_status(context):
    response = client.get("/")
    assert response.status_code == 200
    context.response = response

@when('wysyłam żądanie GET na endpoint "{endpoint}"')
def step_send_request(context, endpoint):
    response = client.get(endpoint)
    context.response = response

@then("otrzymuję odpowiedź z kodem 200")
def step_check_status(context):
    assert context.response.status_code == 200

@then('odpowiedź zawiera pole "rates"')
def step_check_rates(context):
    data = context.response.json()    
    if isinstance(data, list):
        data = data[0]
    assert "rates" in data

@then('odpowiedź zawiera kod waluty')
def step_check_code(context):
    data = context.response.json()    
    assert isinstance(data, list)
    assert len(data) > 0   
    assert isinstance(data[0], str)
    assert data[0] != ""