import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

const BASE_URL = 'http://localhost:8001';

export interface ExchangeRate {  
  currency: string;
  code: string;
  rate: number;
  date: string;
}

@Injectable({
  providedIn: 'root'
})
export class CurrencyService {
  constructor(private http: HttpClient) {}

  getLatestRates(table_type: string, code: string): Observable<any> {
    return this.http.get<any>(`${BASE_URL}/latest-rates/?table_type=${table_type}&code=${code}`);
  }

  getRatesForDate(date: string, table_type: string, code: string): Observable<any> {
    return this.http.get<any>(`${BASE_URL}/rates-date/?date=${date}&table_type=${table_type}&code=${code}`);
  }
 
  getRatesForRange(start: string, end: string, table_type: string, code: string): Observable<any[]> {
    return this.http.get<any[]>(`${BASE_URL}/rates-range/?start=${start}&end=${end}&table_type=${table_type}&code=${code}`);
  }
  
  getAvailableCurrencies(): Observable<any> {
    return this.http.get<any>(`${BASE_URL}/currencies/`);
  }
}