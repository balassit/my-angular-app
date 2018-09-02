import { NgModule } from '@angular/core';
import { MatAutocompleteModule, MatInputModule } from '@angular/material';
import { CdkTableModule } from '@angular/cdk/table';

@NgModule({
  imports: [
    CdkTableModule,
    MatAutocompleteModule,
    MatInputModule
  ],
  exports: [
    CdkTableModule,
    MatAutocompleteModule,
    MatInputModule
  ],
  declarations: []
})
export class MaterialModule { }
