import { Injectable } from '@angular/core';
import { IAppConfig } from '../models/IAppConfig';

@Injectable({
  providedIn: 'root'
})
export class AppConfigService {

  static settings: IAppConfig;

  static load(jsonFile: string): Promise<any> {
    return new Promise((resolve, reject) => {
      const xhr = new XMLHttpRequest();
      xhr.overrideMimeType('application/json');
      xhr.open('GET', jsonFile, true);
      xhr.onreadystatechange = () => {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            this.settings = JSON.parse(xhr.responseText);
            resolve(this.settings);
          } else {
            reject(`Could not load file '${jsonFile}': ${xhr.status}`);
          }
        }
      };
      xhr.send(null);
    });
  }

  constructor() { }
}
