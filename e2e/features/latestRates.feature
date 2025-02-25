Feature: Testy e2e aplikacji Angular

  Scenario: Użytkownik pobiera najnowszy kurs średni dla wszystkich walut
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "A"
    And użytkownik klika przycisk "get-latest"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera najnowszy kurs K/S dla wszystkich walut
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "C"
    And użytkownik klika przycisk "get-latest"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera najnowszy kurs średni dla jednej waluty
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "A"
    And użytkownik klika przycisk "get-latest"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera najnowszy kurs K/S dla jednej waluty
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "C"
    And użytkownik klika przycisk "get-latest"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla wszystkich walut za rok
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera rok "2024"
    And użytkownik klika przycisk "get-year"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla wszystkich walut za rok
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera rok "2024"
    And użytkownik klika przycisk "get-year"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla jednej waluty za rok
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera rok "2024"
    And użytkownik klika przycisk "get-year"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla jednej waluty za rok
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera rok "2024"
    And użytkownik klika przycisk "get-year"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla wszystkich walut za kwartał
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera kwartał "2"
    And użytkownik klika przycisk "get-quarter"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla wszystkich walut za kwartał
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera kwartał "2"
    And użytkownik klika przycisk "get-quarter"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla jednej waluty za kwartał
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera kwartał "2"
    And użytkownik klika przycisk "get-quarter"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla jednej waluty za kwartał
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera kwartał "2"
    And użytkownik klika przycisk "get-quarter"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla wszystkich walut za miesiąc
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera miesiąc "1"
    And użytkownik klika przycisk "get-month"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla wszystkich walut za miesiąc
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera miesiąc "1"
    And użytkownik klika przycisk "get-month"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla jednej waluty za miesiąc
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera miesiąc "1"
    And użytkownik klika przycisk "get-month"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla jednej waluty za miesiąc
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera rok "2024"
    And użytkownik wybiera miesiąc "1"
    And użytkownik klika przycisk "get-month"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla wszystkich walut za dzień
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera datę "31-01-2024"
    And użytkownik klika przycisk "get-date"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla wszystkich walut za dzień
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "all"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera datę "31-01-2024"
    And użytkownik klika przycisk "get-date"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs średni dla jednej waluty za dzień
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "A"
    And użytkownik wybiera datę "31-01-2024"
    And użytkownik klika przycisk "get-date"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik pobiera kurs K/S dla jednej waluty za dzień
    Given użytkownik otworzył stronę główną
    When użytkownik wybiera walutę "USD"
    And użytkownik wybiera kurs "C"
    And użytkownik wybiera datę "31-01-2024"
    And użytkownik klika przycisk "get-date"
    Then widoczna jest tabela z kursami walut

  Scenario: Użytkownik sprawdza listę walut
    Given użytkownik otworzył stronę główną
    When użytkownik sprawdza listę walut
    Then widoczna jest lista walut