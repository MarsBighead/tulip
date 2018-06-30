import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { GenesComponent } from './genes/genes.component';
import { HomeComponent } from './home/home.component';
import { GeneDetailComponent } from './gene-detail/gene-detail.component';

@NgModule({
  declarations: [
    AppComponent,
    GenesComponent,
    HomeComponent,
    GeneDetailComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
