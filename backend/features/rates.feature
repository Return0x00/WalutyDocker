Feature: Pobieranie kursów walut

  Scenario: Pobranie najnowszych kursów z tabeli A
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/latest-rates/?table_type=A"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie najnowszych kursów z tabeli C
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/latest-rates/?table_type=C"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie najnowszego kursu USD z tabeli A
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/latest-rates/?table_type=A&code=USD"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie najnowszego kursu USD z tabeli C
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/latest-rates/?table_type=C&code=USD"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursów dla dnia z tabeli A
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-date/?date=2020-01-07&table_type=A"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursów dla dnia z tabeli C
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-date/?date=2020-01-07&table_type=C"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursu USD dla dnia z tabeli A
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-date/?date=2020-01-07&table_type=A&code=USD"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursu  USD dla dnia z tabeli C
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-date/?date=2020-01-07&table_type=C&code=USD"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursów dla zakresu dat z tabeli A
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-range/?start=2020-01-01&end=2020-01-05&table_type=A"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursów dla zakresu dat z tabeli C
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-range/?start=2020-01-01&end=2020-01-05&table_type=C"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursu USD dla zakresu dat z tabeli A
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-range/?start=2020-01-01&end=2020-01-05&table_type=A&code=USD"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie kursu USD dla zakresu dat z tabeli C
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/rates-range/?start=2020-01-01&end=2020-01-05&table_type=A&code=USD"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera pole "rates"

  Scenario: Pobranie listy walut
    Given API jest uruchomione
    When wysyłam żądanie GET na endpoint "/currencies/"
    Then otrzymuję odpowiedź z kodem 200
    And odpowiedź zawiera kod waluty