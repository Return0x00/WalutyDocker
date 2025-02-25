import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CurrencyService } from './waluty.service';

interface PivotRate {  
  code: string;
  rates: any[]; // Każdy element odpowiada kursowi z danego dnia
}

@Component({
  standalone: true,
  selector: 'app-root',
  imports: [
    CommonModule,
    FormsModule
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})

export class AppComponent implements OnInit {
  responseMessage: string = "";
  selectedCurrency: string = 'all';
  selectedTable: string = 'A';
  selectedDate: string = '2003-01-01';
  selectedYear: number = new Date().getFullYear();
  selectedQuarter: number = 1;
  selectedMonth: number = 1;  
  currencyArr: string[] = [];  
  yearsArr: number[] = [];
  datesArr: string[] = [];
  resultArr: PivotRate[] = [];
  today: string = new Date().toISOString().split('T')[0];
  options: Intl.DateTimeFormatOptions = { year: 'numeric', month: '2-digit', day: '2-digit' };

  constructor(private currencyService: CurrencyService) { }

  ngOnInit(): void {
    const currentYear = new Date().getFullYear();

    for (let y = 2003; y <= currentYear; y++) {
      this.yearsArr.push(y);
    }
    
    this.getAvailableCurrencies();    
    this.getLatestRates();
  }

  getAvailableCurrencies(): void {
    this.currencyService.getAvailableCurrencies().subscribe({
      next: (data: any) => {
        this.currencyArr = data.sort();        
      },
      error: (err) => this.responseMessage ='Status odpowiedzi: ' + (err.error?.detail || err.message)
    });
  }

  getLatestRates(): void {
    this.currencyService.getLatestRates(this.selectedTable, this.selectedCurrency).subscribe({
      next: (data: any) => {        
        const effectiveDate = data.effectiveDate || this.today;
        this.datesArr = [effectiveDate];
        let rates = data.rates || [];
        this.responseMessage = "";
  
        this.resultArr = rates.map((rate: any) => ({          
          code: (this.selectedCurrency === "all") ? rate.code : this.selectedCurrency,
          rates: [this.formatRate(rate)]
        }));
      },
      error: (err) => this.responseMessage ='Status odpowiedzi: ' + (err.error?.detail || err.message)
    });
  }

  getRateForDate(): void {
    if (!this.selectedDate) return;
    this.currencyService.getRatesForDate(this.selectedDate, this.selectedTable, this.selectedCurrency).subscribe({
      next: (data: any) => {        
        const effectiveDate = data.effectiveDate || this.selectedDate;
        this.datesArr = [effectiveDate];
        let rates = data.rates || [];
        this.responseMessage = "";     

        this.resultArr = rates.map((rate: any) => ({          
          code: (this.selectedCurrency === "all") ? rate.code : this.selectedCurrency,
          rates: [this.formatRate(rate)]
        }));
      },
      error: (err) => this.responseMessage ='Status odpowiedzi: ' + (err.error?.detail || err.message)
    });
  }

  getRateForRange(startDate: string, endDate: string): void {
    this.currencyService.getRatesForRange(startDate, endDate, this.selectedTable, this.selectedCurrency).subscribe({
      next: (data: any[]) => {
        data.sort((a, b) => new Date(a.effectiveDate).getTime() - new Date(b.effectiveDate).getTime());
        this.datesArr.push(...data.map(day => day.effectiveDate));
        this.responseMessage = "";
   
        const currencyMap: { [key: string]: PivotRate } = {};
        data.forEach(day => {
          let rates = day.rates || [];

          rates.forEach((rate: any) => {
            if (!currencyMap[rate.code]) {
              currencyMap[rate.code] = {               
                code: (this.selectedCurrency === "all") ? rate.code : this.selectedCurrency,
                rates: new Array(data.length).fill(null)
              };
            }
            const dayIndex = this.datesArr.indexOf(day.effectiveDate);
            currencyMap[rate.code].rates[dayIndex] = this.formatRate(rate);
          });
        });
        this.resultArr.push(...Object.values(currencyMap));
      },
      error: (err) => {
        this.responseMessage ='Status odpowiedzi: ' + (err.error?.detail || err.message);
      }
    });
  }

  getRateForMonth(): void {
    const startDate = new Date(this.selectedYear, this.selectedMonth - 1, 1).toLocaleDateString('en-CA', this.options);
    const endDate = new Date(this.selectedYear, this.selectedMonth, 0).toLocaleDateString('en-CA', this.options);
    this.resultArr = [];
    this.datesArr = [];

    this.getRateForRange(startDate, endDate);
  }

  getRateForQuarter(clearData: boolean = true, quarter: number = this.selectedQuarter): void {
    const startMonth = quarter * 3;
    const endMonth = startMonth + 3;  
    const startDate = new Date(this.selectedYear, startMonth, 1).toLocaleDateString('en-CA', this.options);
    const endDate = new Date(this.selectedYear, endMonth, 0).toLocaleDateString('en-CA', this.options);
    
    if (clearData) {
      this.resultArr = [];
      this.datesArr = [];
    }

    this.getRateForRange(startDate, endDate);
  }

  getRateForYear(): void {
    this.resultArr = [];
    this.datesArr = [];  

    for (let i = 0; i < 4; i++) {      
      this.getRateForQuarter(false, i);
    }    
  }

  private formatRate(rate: any): string {   
    return this.selectedTable === 'C' ? `${rate.bid}/${rate.ask}` : `${rate.mid}`;
  }
}